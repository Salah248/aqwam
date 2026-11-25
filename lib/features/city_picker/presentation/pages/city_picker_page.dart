import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/aqwam_tokens.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../domain/entities/location_entities.dart';
import '../../domain/entities/location_names.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../cubit/city_picker_cubit.dart';
import '../cubit/city_picker_state.dart';
import '../widgets/city_picker_chip.dart';
import '../widgets/city_picker_confirmation_bar.dart';
import '../widgets/city_picker_list.dart';
import '../widgets/city_picker_search_field.dart';

class CityPickerPage extends StatelessWidget {
  const CityPickerPage({super.key});

  @override
  Widget build(BuildContext context) => const CityPickerView();
}

class CityPickerView extends StatefulWidget {
  const CityPickerView({super.key});

  @override
  State<CityPickerView> createState() => _CityPickerViewState();
}

class _CityPickerViewState extends State<CityPickerView> {
  final _searchController = TextEditingController();
  bool _saving = false;

  Future<void> _confirm(
    CityPickerCubit cubit,
    AppLocalizations localizations,
  ) async {
    if (_saving) return; // يمنع الضغط المزدوج
    _saving = true;
    final result = await cubit.confirm();
    if (!mounted) return;
    switch (result) {
      case Success():
        context.pop(true);
      case Err():
        _saving = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.cityPickerSaveError)),
        );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final cubit = context.read<CityPickerCubit>();

    return BlocListener<CityPickerCubit, CityPickerState>(
      // The cubit clears the query on every selection; mirror it in the field.
      listenWhen: (previous, current) =>
          previous.query.isNotEmpty && current.query.isEmpty,
      listener: (context, state) => _searchController.clear(),
      child: BlocBuilder<CityPickerCubit, CityPickerState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              localizations.cityPickerTitle,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: AqwamFontSize.f14,
              ),
            ),
            centerTitle: true,
          ),
          body: switch (state.status) {
            CityPickerStatus.loading => const _CityPickerLoadingSkeleton(),
            CityPickerStatus.failure => Center(
              child: Padding(
                padding: EdgeInsetsDirectional.all(AqwamSpacing.w16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _failureMessage(localizations, state.failure),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: AqwamSpacing.h8),
                    CustomElevatedButton(
                      text: localizations.cityPickerRetry,
                      onPressed: cubit.load,
                    ),
                  ],
                ),
              ),
            ),
            CityPickerStatus.ready => _content(
              context,
              state,
              cubit,
              localizations,
              languageCode,
            ),
            CityPickerStatus.empty => Center(
              child: Text(localizations.cityPickerEmpty),
            ),
          },
          bottomNavigationBar: switch ((
            state.country,
            state.region,
            state.city,
          )) {
            (final country?, final region?, final city?) =>
              CityPickerConfirmationBar(
                summary: state.hasRegionStep
                    ? localizations.cityPickerSelectedLocation(
                        city.name(state.languageCode),
                        region.name(state.languageCode),
                        country.name(state.languageCode),
                      )
                    : localizations.cityPickerSelectedLocationShort(
                        city.name(state.languageCode),
                        country.name(state.languageCode),
                      ),
                buttonLabel: localizations.cityPickerConfirmLocation,
                // Phase 6 replaces this with saving the selection.
                onPressed: () => _confirm(cubit, localizations),
              ),
            _ => null,
          },
        ),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    CityPickerState state,
    CityPickerCubit cubit,
    AppLocalizations localizations,
    String languageCode,
  ) {
    final lang = state.languageCode;
    final country = state.country;
    final regionLabel = country?.regionLabel(lang);

    final stepLabel = switch (state.step) {
      CityPickerStep.country => localizations.cityPickerCountry,
      CityPickerStep.region => regionLabel!,
      CityPickerStep.city => localizations.cityPickerCity,
    };
    final hint = switch (state.step) {
      CityPickerStep.country => localizations.cityPickerCountrySearchHint,
      CityPickerStep.region => localizations.cityPickerRegionSearchHint(
        regionLabel!,
      ),
      CityPickerStep.city => localizations.cityPickerCitySearchHint,
    };

    return ListView(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: AqwamSpacing.w16,
        vertical: AqwamSpacing.h16,
      ),
      children: [
        Wrap(
          spacing: AqwamSize.w6,
          runSpacing: AqwamSize.w6,
          children: [
            CityPickerChip(
              label: country?.name(lang) ?? localizations.cityPickerCountry,
              selected: country != null,
              onDeleted: () => cubit.goToStep(CityPickerStep.country),
            ),
            if (state.hasRegionStep)
              CityPickerChip(
                label:
                    state.region?.name(lang) ??
                    regionLabel ??
                    localizations.cityPickerRegionGeneric,
                selected: state.region != null,
                onDeleted: () => cubit.goToStep(CityPickerStep.region),
              ),
            CityPickerChip(
              label: state.city?.name(lang) ?? localizations.cityPickerCity,
              selected: state.city != null,
              onDeleted: () => cubit.goToStep(CityPickerStep.city),
            ),
          ],
        ),
        SizedBox(height: AqwamSpacing.h8),
        CityPickerSearchField(
          controller: _searchController,
          hintText: hint,
          onChanged: cubit.search,
        ),
        SizedBox(height: AqwamSpacing.h8),
        Text(
          localizations.cityPickerStepLabel(
            formatInt(state.stepNumber, languageCode: languageCode),
            formatInt(state.totalSteps, languageCode: languageCode),
            stepLabel,
          ),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).extension<AqwamColors>()!.textSecondary,
          ),
        ),
        SizedBox(height: AqwamSpacing.h8),
        switch (state.step) {
          CityPickerStep.country => CityPickerList<Country>(
            items: state.visibleCountries,
            labelOf: (item) => item.name(lang),
            onTap: cubit.selectCountry,
            emptyText: localizations.cityPickerNoResults,
          ),
          CityPickerStep.region => CityPickerList<Region>(
            items: state.visibleRegions,
            labelOf: (item) => item.name(lang),
            onTap: cubit.selectRegion,
            emptyText: localizations.cityPickerNoResults,
          ),
          CityPickerStep.city => CityPickerList<City>(
            items: state.visibleCities,
            labelOf: (item) => item.name(lang),
            isSelected: (item) => item == state.city,
            onTap: cubit.selectCity,
            emptyText: localizations.cityPickerNoResults,
          ),
        },
      ],
    );
  }
}

String _failureMessage(AppLocalizations localizations, Failure? failure) =>
    switch (failure) {
      StorageFailure() => localizations.cityPickerStorageError,
      _ => localizations.cityPickerLoadError,
    };

class _CityPickerLoadingSkeleton extends StatelessWidget {
  const _CityPickerLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AqwamColors>()!;
    return ExcludeSemantics(
      child: ListView(
        padding: EdgeInsetsDirectional.all(AqwamSpacing.w16),
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.divider),
              borderRadius: BorderRadius.circular(AqwamRadius.r12),
            ),
            child: Column(
              children: [
                for (var index = 0; index < 5; index++)
                  Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: AqwamSpacing.w12,
                        ),
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: colors.divider,
                        ),
                        title: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(
                                AqwamRadius.r10,
                              ),
                            ),
                            child: SizedBox(
                              width: AqwamSize.w150,
                              height: AqwamSpacing.h8,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: colors.divider,
                        ),
                      ),
                      if (index < 4)
                        Divider(
                          height: AqwamSpacing.h1,
                          thickness: AqwamSpacing.h1,
                          color: colors.divider,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
