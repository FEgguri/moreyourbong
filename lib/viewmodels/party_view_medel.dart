import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moreyourbong/models/party_model.dart';
import 'package:moreyourbong/repositories/party_repository.dart';

class PartyViewMedel
    extends AutoDisposeFamilyAsyncNotifier<List<Party>, String> {
  @override
  Future<List<Party>> build(String arg) async {
    final partyrepo = PartyRepository();
    return await partyrepo.getAll(arg);
  }

  // 모임 생성 시 반영
  Future<void> addParty(String address) async {
    final repository = PartyRepository();
    state = AsyncValue.data(await repository.getAll(address));
  }
}

// Party Provider
final partyViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<PartyViewMedel, List<Party>, String>(() {
  return PartyViewMedel();
});
