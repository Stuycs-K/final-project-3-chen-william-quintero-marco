import java.util.*;
public class Driver{
    public static void main(String[] args){
        Map test = new Map(32, 18, 1600, 900);
        System.out.println(test.mapDiff());
        test.getMap();

        //Arrays.toString(test.mapDiff());
    }
}   