#import "ThePrinterManager.h"

@interface ThePrinterManager()
                                        // objectid  thePrinter
@property(nonatomic) NSMutableDictionary<NSString *, ThePrinter*> *objectDict;

@end


@implementation ThePrinterManager

static ThePrinterManager *sharedData_ = nil;

+ (ThePrinterManager *)sharedManager {
    @synchronized(self) {
        if (sharedData_ == nil) {
            sharedData_ = [ThePrinterManager new];
        }
        return sharedData_;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _objectDict = [NSMutableDictionary new];
    }

    return self;
}

- (void) removeAll{
    @synchronized (self) {
        if (_objectDict == nil) return;
        [_objectDict removeAllObjects];
    }
}

- (NSString *)add:(ThePrinter*)thePrinterObj {
    @synchronized (self) {
        NSString *printerTarget = [thePrinterObj getPrinterTarget];

        for (NSString *aKey in [_objectDict allKeys] )
        {
            NSLog(@"Here is the key: %@", aKey);
        }
        if ([_objectDict.allKeys containsObject:printerTarget] == NO) {
            NSLog(@"Setting the instance for the printer");
            [_objectDict addEntriesFromDictionary:@{printerTarget: thePrinterObj}];
        } else {
            NSLog(@"The key already exists");
        }
        return printerTarget;
    }
}

- (ThePrinter*)getObject:(NSString *) identifier {
    @synchronized (self) {
        return _objectDict[identifier];
    }
}

- (void)remove:(NSString *) identifier {
    @synchronized (self) {
        _objectDict[identifier] = nil;
    }
}


@end
