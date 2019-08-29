package blueGemstone.dao;

import org.apache.ibatis.annotations.Param;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;

public interface PublicMapper {

	int select();

	int insertVarChange(VarChange varChange);

	int insertVarAvgChange(VarAvgChange varAvgChange);

	float getVarChangeAvgValue(@Param("name") String name, @Param("time") String time);

	int updateVarChange(@Param("name") String name, @Param("time") String time);

}
