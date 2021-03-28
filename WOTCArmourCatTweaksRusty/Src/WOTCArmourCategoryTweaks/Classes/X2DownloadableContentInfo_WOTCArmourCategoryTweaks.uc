//*******************************************************************************************
//  FILE:   XComDownloadableContentInfo_WOTCArmourCategoryTweaks.uc                                    
//  
//	File created by RustyDios	16/11/19	01:30	
//	LAST UPDATED				01/09/20	12:30
//
//	Unreal script to change the category of the advanced armours, which determines what a soldier class can use.
//	Separates 'base' armours instead of all being ArmorCat "soldier"
//
//*******************************************************************************************

class X2DownloadableContentInfo_WOTCArmourCategoryTweaks extends X2DownloadableContentInfo;

struct ArmourCatSwap
{
	var name TemplateName;
	var name NewArmourCat;
};

// var config stuffs //not used
var config array<ArmourCatSwap> ArmourCatSwaps;

/// Called on new campaign while this DLC / Mod is installed
static event InstallNewCampaign(XComGameState StartState){}		//empty_func

/// Called on first time load game if not already installed	
static event OnLoadedSavedGame(){}								//empty_func

//*******************************************************************************************
//		OPTC code to run the helper function
//*******************************************************************************************

static event OnPostTemplatesCreated()
{
	local int acs;

	//RustyArmourCatSwap('TemplateName', 'NewArmourCat');		// desc
	for (acs = 0 ; acs <= default.ArmourCatSwaps.length ; acs++)
	{
		RustyArmourCatSwap(default.ArmourCatSwaps[acs].TemplateName, default.ArmourCatSwaps[acs].NewArmourCat);
	}
}

//*******************************************************************************************
//		Helper function to perform the swap
//*******************************************************************************************
static function RustyArmourCatSwap(name TemplateName, name NewArmourCat)
{
	local X2ItemTemplateManager	ItemTemplateManager;

	local X2ItemTemplate		CurrentItem;
	local X2ArmorTemplate		Template;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	CurrentItem = ItemTemplateManager.FindItemTemplate(TemplateName);
	Template = X2ArmorTemplate(CurrentItem);

	if (Template != none)
	{
		Template.ArmorCat = NewArmourCat;
		`LOG("Armour Template Adjusted: " @TemplateName@ " NewArmourCat is: " @NewArmourCat,,'WOTCArmourCategoryTweaks');
	}
}

//*******************************************************************************************
//*******************************************************************************************
