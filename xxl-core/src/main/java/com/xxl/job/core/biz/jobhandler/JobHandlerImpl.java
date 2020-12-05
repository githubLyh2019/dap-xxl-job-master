package com.xxl.job.core.biz.jobhandler;

import com.xxl.job.core.biz.JobHanlerBiz;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.executor.XxlJobExecutor;

import java.util.Set;

public class JobHandlerImpl implements JobHanlerBiz{

    @Override
    public ReturnT<Set<String>> acquireXxlJob() {
        Set xxlJobSet = XxlJobExecutor.acquireXxlJob();
        return new ReturnT<Set<String>>(xxlJobSet);
    }
}
