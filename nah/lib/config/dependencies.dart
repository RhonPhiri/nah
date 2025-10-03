import 'package:nah/ui/core/ui/app_shell/view_model/app_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get devProviders {
  return [ChangeNotifierProvider(create: (context) => AppState())];
}
