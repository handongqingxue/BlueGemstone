package blueGemstone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnRecord;

public interface PublicMapper {

	int select();

	int insertVarChange(VarChange varChange);

	int insertVarAvgChange(VarAvgChange varAvgChange);

	float getVarChangeAvgValue(@Param("name") String name, @Param("time") String time);

	int updateVarChange(@Param("name") String name, @Param("time") String time);

	List<VarChange> selectVarChangeLineData(@Param("name") String name);

	List<VarChange> selectVarChangeReportData(@Param("name") String name);

	List<VarAvgChange> selectVarAvgChangeLineData(String name);

	List<WarnRecord> selectWarnRecordReportData();

	int insertWarnRecord(WarnRecord warnRecord);

}
