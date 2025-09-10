import 'package:nah/data/repository/hymn/hymn_repository.dart';
import 'package:nah/data/repository/hymn/hymn_repository_embedded.dart';
import 'package:nah/data/repository/hymnal/hymnal_repository.dart';
import 'package:nah/data/repository/hymnal/hymnal_repository_embedded.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository.dart';
import 'package:nah/data/repository/on_boarding/on_boarding_repository_local.dart';
import 'package:nah/data/service/embedded/data_service_embedded.dart';
import 'package:nah/data/service/shared_preferences_service.dart';
import 'package:nah/domain/use_cases/hymn/load_hymn_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get devProviders => [
  Provider(create: (context) => SharedPrefService()),
  Provider(create: (context) => DataServiceEmbedded()),
  ChangeNotifierProvider<OnBoardingRepository>(
    create: (context) =>
        OnBoardingRepositoryLocal(sharedPrefService: context.read()),
  ),

  Provider<HymnalRepository>(
    create: (context) => HymnalRepositoryEmbedded(
      dataServiceEmbedded: context.read(),
      sharedPrefService: context.read(),
    ),
  ),
  Provider<HymnRepository>(
    create: (context) =>
        HymnRepositoryEmbedded(dataServiceEmbedded: context.read()),
  ),
  Provider<LoadHymnUseCase>(
    lazy: true,
    create: (context) => LoadHymnUseCase(
      hymnRepository: context.read(),
      hymnalRepository: context.read(),
    ),
  ),
];
