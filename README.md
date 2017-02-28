# GBException
GBException is used to capture the app crash information, pop-up prompt the user, will collapse information sent to the server. 

## How To Use In Self Projects

- [Download GBException](https://github.com/fengguibin/GBException/archive/master.zip) and try out the included Mac and iPhone example apps
- The import KitUncaughtExceptionHandler folder for the engineering.
- The import header file  of MyUncaughtExceptionHandler.h at AppDelegate.m
- AppDelegate.m Add send collapse method (directly paste method.  send url according to oneself  to modify)
-  "- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions"" add code   [MyUncaughtExceptionHandler setDefaultHandler];        
NSString *bugPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
NSString *dataPath = [bugPath stringByAppendingPathComponent:@"Exception.txt"]; NSData *data = [NSData dataWithContentsOfFile:dataPath];
if (data != nil) {
[self sendExceptionLogWithData:data dataPath:dataPath];
 }

## Communication

- If you **need help**,open an issue Leave your contact way I will contact you
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
