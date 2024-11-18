package com.shop.test.persitence;

import static org.junit.jupiter.api.Assertions.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.jupiter.api.Test;

public class JDBCTest {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {

		try (Connection con = DriverManager.getConnection(
				// Oracle19 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:orcl"
				// Oracle11 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:XE"
				"jdbc:oracle:thin:@localhost:1521:orcl", "SHOP", "1234")) {
			System.out.println(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}

	}

}
