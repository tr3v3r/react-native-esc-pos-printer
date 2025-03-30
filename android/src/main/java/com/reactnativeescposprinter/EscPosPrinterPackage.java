package com.escposprinter;

import androidx.annotation.Nullable;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.module.model.ReactModuleInfo;
import com.facebook.react.module.model.ReactModuleInfoProvider;
import com.facebook.react.TurboReactPackage;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class EscPosPrinterPackage extends TurboReactPackage {

    @Nullable
    @Override
    public NativeModule getModule(String name, ReactApplicationContext reactContext) {
        if (name.equals(EscPosPrinterModule.NAME)) {
            return new EscPosPrinterModule(reactContext);
        } if(name.equals(EscPosPrinterDiscoveryModule.NAME)) {
            return new EscPosPrinterDiscoveryModule(reactContext);
        } else {
            return null;
        }
    }

    @Override
    public ReactModuleInfoProvider getReactModuleInfoProvider() {
        return () -> {
            final Map<String, ReactModuleInfo> moduleInfos = new HashMap<>();
            boolean isTurboModule = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED;
            moduleInfos.put(
                    EscPosPrinterModule.NAME,
                    new ReactModuleInfo(
                            EscPosPrinterModule.NAME,
                            EscPosPrinterModule.NAME,
                            false, // canOverrideExistingModule
                            false, // needsEagerInit
                            true, // hasConstants
                            false, // isCxxModule
                            isTurboModule // isTurboModule
            ));
            moduleInfos.put(
                    EscPosPrinterDiscoveryModule.NAME,
                    new ReactModuleInfo(
                            EscPosPrinterDiscoveryModule.NAME,
                            EscPosPrinterDiscoveryModule.NAME,
                            false, // canOverrideExistingModule
                            false, // needsEagerInit
                            true, // hasConstants
                            false, // isCxxModule
                            isTurboModule // isTurboModule
            ));

            return moduleInfos;
        };
    }
}
