import 'package:grpc/grpc.dart' as grpc;
import 'package:quas/service.dart';

class Server {
  Future<void> run() async {
    final server = grpc.Server([QuaService()]);
    await server.serve(port: 7777);
    print('Serving on the port: ${server.port}');
  }
}

Future<void> main() async {
  await Server().run();
}
