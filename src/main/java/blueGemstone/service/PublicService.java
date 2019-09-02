package blueGemstone.service;

import java.util.List;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnRecord;

public interface PublicService {

	int insertVarChange();

	int insertVarAvgChange();
	
	int insertWarnRecord(VarChange varChange);

	List<VarChange> selectVarChangeLineData(String name, int page, int row);

	List<VarChange> selectVarChangeReportData(String yaqiang);

	List<VarAvgChange> selectVarAvgChangeLineData(String name, int page, int row);

	List<WarnRecord> selectWarnRecordReportData(String name);

}
