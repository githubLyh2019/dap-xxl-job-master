package com.xxl.job.core.biz;

import com.xxl.job.core.biz.model.RegistryParam;
import com.xxl.job.core.biz.model.ReturnT;

import java.util.Set;

public interface JobHanlerBiz {
    /**
     *
     *
     * @param
     * @return
     */
    public ReturnT<Set<String>> acquireXxlJob();
}
