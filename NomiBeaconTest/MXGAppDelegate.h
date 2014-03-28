//
//  MXGAppDelegate.h
//  NomiBeaconTest
//
//  Created by Jayden.Ma on 28/3/14.
//  Copyright (c) 2014 Maxus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
