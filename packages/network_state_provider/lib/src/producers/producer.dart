abstract class NetworkStateProducer {
  Stream<bool> hasConnection();

  void dispose();
}
