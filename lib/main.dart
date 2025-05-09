import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:pro_deals_admin/modal/order_model.dart';
import 'package:pro_deals_admin/screens/order/view_order.dart';
import 'package:pro_deals_admin/utils/imports.dart';
import 'firebase_options.dart';
import 'package:window_size/window_size.dart' as window_size;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  window_size.getWindowInfo().then((window) async {
    final screen = window.screen;
    if (screen != null) {
      final screenFrame = screen.visibleFrame;
      final width = (screenFrame.width * 0.85).roundToDouble();
      final height = screenFrame.height * 0.60;

      window_size.setWindowFrame(Rect.fromLTWH(
          screenFrame.width * 0.075, 0, width, screenFrame.height));

      window_size.setWindowMinSize(Size(width, height));

      window_size.setWindowTitle('Pro deals');
    }
  });

  Firestore.initialize(projectId);
  await GetStorage.init();
  runApp(
    const WindowApp(),
  );
}

class WindowApp extends StatelessWidget {
  const WindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Pro Deals Admin",
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/view_plan':
            final MembershipPlanModel plan =
                settings.arguments as MembershipPlanModel;
            return _createRoute(ViewPlan(plan: plan));
          case '/add_update_plan':
            final plan = settings.arguments;
            return _createRoute(AddUpdatePlan(data: plan));

          case '/view_banner':
            final BannerListModel data = settings.arguments as BannerListModel;
            return _createRoute(ViewBanner(model: data));
          case '/add_update_banner':
            final plan = settings.arguments;
            return _createRoute(AddUpdateBanner(data: plan));
          case '/view_business':
            final business = settings.arguments as AllBusinessModel;
            return _createRoute(ViewBusiness(business: business));
          case '/update_business':
            final business = settings.arguments as AllBusinessModel;
            return _createRoute(UpdateBusiness(business: business));
          case '/add_business':
            return _createRoute(const AddBusiness());

          case '/add_notification':
            return _createRoute(const CreateNotification());

          case '/login':
            return _createRoute(const Login());

          case '/panel':
            return _createRoute(const panel());

          case '/staff_panel':
            return _createRoute(const StaffPanel());

          case '/view_order':
            final order = settings.arguments as OrderModal;
            return _createRoute(ViewOrder(order: order));

          default:
            return FluentPageRoute(builder: (context) => Container());
        }
      },
      routes: {
        '/': (context) => const IntroPage(),
      },
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
