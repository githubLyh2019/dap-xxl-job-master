package com.xxl.job.core.biz.impl;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class Test {
    @org.junit.Test
    public void ceshi(){
        ceshi t1 = new ceshi(){
            @Override
            public String run() {
                return "哈哈";
            }
        };
        System.out.println(t1.run());

        ceshi t2 = this::printString;
        System.out.println(t2.run());

        printString("静态方法引用",System.out::println);


        List<Integer> list = Arrays.asList(1,2,5,6,7,4,7,89,0,0,34);
        list.stream().distinct().map(
                a -> {
                    if(a==1||a==34) {
                         a = 10000;
                    }
                 return a;
                }).limit(3).sorted().forEach(System.out::println);
    }

    public void printString(String str,ce t){
        t.run(str);
    }

    public String printString(){
        return "我在测试啊";
    }
}



interface ceshi{
    public String run();
}


interface ce{
    public void run(String string);
}
