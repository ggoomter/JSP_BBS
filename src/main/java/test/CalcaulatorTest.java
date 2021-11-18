package test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class CalcaulatorTest {

    @Test
    void test() {
        fail("Not yet implemented");
    }
    
    //원래소스. Calculator라는 객체안에 sum이라는 메소드가 있고 인자2개를 합치는 기능.
    public int sum(int a, int b) {
        return a+b;
    }
    
    
    @Test
    public void testSum() {
      //given    
      Calculator calc = new Calculator();
      
        
      //when    
      //then
      assertEquals(30 , calc.sum(10,20));
    }

}
