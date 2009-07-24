//
//  AppDelegate.h
//  RaisedEditor2
//
//  Created by Andy Kim on 1/29/08.
//  Copyright 2008 Potion Factory LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppDelegate : NSObject
{
	IBOutlet NSWindow *mainWindow;
    
    IBOutlet NSTextField *nameTextField;
    IBOutlet NSTextField *licenseTextField;
    
    IBOutlet NSProgressIndicator *spinner;
}

- (IBAction)buy:(id)sender;
- (IBAction)validate:(id)sender;
@end
