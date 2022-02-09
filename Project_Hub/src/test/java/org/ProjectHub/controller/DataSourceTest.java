package org.ProjectHub.controller;

import static org.junit.Assert.fail;

import java.sql.Connection;
 
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
 
@RunWith(SpringJUnit4ClassRunner.class)
//xml설정을 이용하는 경우
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//JAVA설정을 사용하는 경우
/* @ContextConfiguration(classes= {RootConfig.class}) */
@Log4j
public class DataSourceTest {
 
    @Setter(onMethod_ = {@Autowired})
    private DataSource dataSource;
    
    @Setter(onMethod_ = {@Autowired})
    private SqlSessionFactory sessionFactory;
    
    @Test
    public void testConnection() {
        try (Connection con= dataSource.getConnection()){
            
            log.info(con);
            
        } catch (Exception e) {
            fail(e.getMessage());
            
        }
    }
    
}
 

