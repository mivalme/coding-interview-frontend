import 'package:go_router/go_router.dart';
import '../../features/exchange/presentation/pages/exchange_page.dart';

final appRouter = GoRouter(
  routes: [GoRoute(path: '/', builder: (_, __) => const ExchangePage())],
);
