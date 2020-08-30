package com.salesmanager.web.tags;

import java.util.ArrayList;
import java.util.List;

import com.salesmanager.web.util.Utility;

public class TestMain {
	 public static void main(String[] a){
		 List<Integer> s = new ArrayList<Integer>();
		 s.add(1);
		 s.add(4);
		 s.add(6);
		 s.add(23);
		 s.add(10);
		 
		 int size = Utility.getNumPages(s.size(),2);
		 System.out.println(Utility.chopped(s, size));
	 }
}
