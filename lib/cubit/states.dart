//first thing is to create logic for is 1.index in bottom nav
//second: database we will use .then a lot to emit new states
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangedBottomNavState extends AppStates{}//the new tasks screen

class AppCreateDatabaseState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteDatabaseState extends AppStates{}

class AppChangedBottomSheetState extends AppStates{}
