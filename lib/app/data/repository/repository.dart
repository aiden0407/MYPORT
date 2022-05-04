import 'package:folio/app/data/provider/api_provider.dart';

class MyRepository {
  final MyApiProvider apiProvider;
  MyRepository({required this.apiProvider}) : assert(apiProvider != null);

  getRefresh() {
    return apiProvider.getRefresh();
  }
  postSignUp(body) {
    return apiProvider.postSignUp(body);
  }
  postLogIn(email, password) {
    return apiProvider.postLogIn(email, password);
  }


  getFindEmail(name, birth) {
    return apiProvider.getFindEmail(name, birth);
  }
  getResetPassword(email) {
    return apiProvider.getResetPassword(email);
  }


  getRegion() {
    return apiProvider.getRegion();
  }
  getRegionDetail(String code) {
    return apiProvider.getRegionDetail(code);
  }
  getUniv() {
    return apiProvider.getUniv();
  }
  getPhone(String phone) {
    return apiProvider.getPhone(phone);
  }
  getEmail(String email) {
    return apiProvider.getEmail(email);
  }


  getHome() {
    return apiProvider.getHome();
  }


  getTeam() {
    return apiProvider.getTeam();
  }
  getTeamDetail(String teamId) {
    return apiProvider.getTeamDetail(teamId);
  }
  postTeamMaking(int type, body) {
    return apiProvider.postTeamMaking(type, body);
  }
  putTeamEdit(String teamId, int type, body) {
    return apiProvider.putTeamEdit(teamId, type, body);
  }
  deleteTeam(String teamId) {
    return apiProvider.deleteTeam(teamId);
  }
  patchTeamEditRecruit(String teamId) {
    return apiProvider.patchTeamEditRecruit(teamId);
  }
  patchTeamAccept(String teamId, String memberId) {
    return apiProvider.patchTeamAccept(teamId, memberId);
  }
  patchTeamRefuse(String teamId, String memberId) {
    return apiProvider.patchTeamRefuse(teamId, memberId);
  }
  patchTeamApply(String teamId) {
    return apiProvider.patchTeamApply(teamId);
  }
  deleteTeamLeave(String teamId) {
    return apiProvider.deleteTeamLeave(teamId);
  }


  getContest() {
    return apiProvider.getContest();
  }
  getContestDetail(String contestId) {
    return apiProvider.getContestDetail(contestId);
  }
  postContestBookmark(String contestId) {
    return apiProvider.postContestBookmark(contestId);
  }
  deleteContestBookmark(String contestId) {
    return apiProvider.deleteContestBookmark(contestId);
  }


  getOutdoor() {
    return apiProvider.getOutdoor();
  }
  getOutdoorDetail(String outdoorId) {
    return apiProvider.getOutdoorDetail(outdoorId);
  }
  postOutdoorBookmark(String outdoorId) {
    return apiProvider.postOutdoorBookmark(outdoorId);
  }
  deleteOutdoorBookmark(String outdoorId) {
    return apiProvider.deleteOutdoorBookmark(outdoorId);
  }


  getProfileMy() {
    return apiProvider.getProfileMy();
  }
  getPortfolioMy() {
    return apiProvider.getPortfolioMy();
  }
  getProfileOther(String userId) {
    return apiProvider.getProfileOther(userId);
  }
  getPortfolioOther(String userId) {
    return apiProvider.getPortfolioOther(userId);
  }

}