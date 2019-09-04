package blueGemstone.service;

import java.util.List;
import java.util.Map;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;

public interface PublicService {

	Integer insertVarChange();

	Integer insertVarAvgChange();
	
	Integer insertWarnRecord(VarChange varChange);

	List<VarChange> selectVarChangeLineData(String name, int page, int row);

	List<VarChange> selectVarChangeReportData(String yaqiang);

	List<VarAvgChange> selectVarAvgChangeLineData(String name, int page, int row);

	List<WarnRecord> selectWarnRecordReportData(String name);

	List<WarnHistoryRecord> selectWarnHistoryRecordReportData(String name);

	Integer updateWarnRecord();

	List<Map<String, Object>> getCurrentVarValueList();

}
