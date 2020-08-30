package com.salesmanager.web.util;

import java.util.ArrayList;
import java.util.List;

public class Utility {

	public static int getNumPages(int total, int pageSize){
		if(total <= pageSize){
			return 1;
		}else{
			if(Math.abs(total/pageSize) > 0){
				return Math.abs(total/pageSize)+1;
			}
			return Math.abs(total/pageSize);
		}
	}
	
	public static <T> List<List<T>> chopped(List<T> list, final int L) {
        List<List<T>> parts = new ArrayList<List<T>>();
        final int N = list.size();
        for (int i = 0; i < N; i += L) {
            	parts.add(new ArrayList<T>(
                list.subList(i, Math.min(N, i + L)))
            );
        }
       
        return parts;
    }
}
