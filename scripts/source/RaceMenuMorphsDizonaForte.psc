ScriptName RaceMenuMorphsDizona Extends RaceMenuBase

; Version data
Int Property SKEE_VERSION = 1 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly
Int Property RM_Dizona_VERSION = 1 AutoReadOnly
Int Property Version = 0 Auto

String Property CALLBACK_PART = "ChangeMorph" AutoReadOnly

String Property CATEGORY_KEY = "rsm_bodymorph_BME" AutoReadOnly
String Property MORPH_KEY = "Dizona.esp" AutoReadOnly

String[] morphs

Event OnInit()
	Parent.OnInit()
	Version = RM_Dizona_VERSION
EndEvent

Bool Function CheckNiOverride()
	Return SKSE.GetPluginVersion("skee") >= SKEE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

Function InitMorphNames()
	morphs     = new String[90]
	morphs[0]  = "Dizona to BMEHigh"
    morphs[1]  = "Dizona BodyBuilder"
    morphs[2]  = "Dizona to SAMHigh"
	morphs[3]  = "Dizona to SAMUAL"
	morphs[4]  = "Dizona to SAMSON"
	morphs[5]  = "Dizona ForteHigh"
	morphs[6]  = "Dizona Apple Cheeks"
	morphs[7]  = "Dizona Tight Cheeks"
	morphs[8]  = "Dizona Butt Crack"
	morphs[9]  = "Dizona Fat Ass"
	morphs[10] = "Dizona Push Butt"
	morphs[11] = "Dizona Small Butt"
	morphs[12] = "Dizona Round Cheeks"
	morphs[13] = "Dizona Butt Up"
	morphs[14] = "Dizona Butt Down"
	morphs[15] = "Dizona Spread Cheeks"
	morphs[16] = "Dizona Six Pack"
	morphs[17] = "Dizona Stomach Lining"
	morphs[18] = "Dizona Belly Pup"
	morphs[19] = "Dizona Belly Low"
	morphs[20] = "Dizona Big Belly"
	morphs[21] = "Dizona Beer Gut"
	morphs[22] = "Dizona Begger Belly"
	morphs[23] = "Dizona Belly Button Innie"
	morphs[24] = "Dizona Belly Button Out"
	morphs[25] = "Dizona Shoulders High"
	morphs[26] = "Dizona Shoulders Intrude"
	morphs[27] = "Dizona Shoulder Blades"
	morphs[28] = "Dizona Shoulder Blades In"
	morphs[29] = "Dizona Shoulders Up"
	morphs[30] = "Dizona Shoulders Down"
	morphs[31] = "Dizona Forearms Slim"
	morphs[32] = "Dizona Forearms Thick"
	morphs[33] = "Dizona Arms Extend"
	morphs[34] = "Dizona Front Biceps Macho"
	morphs[35] = "Dizona Front Biceps Thin"
	morphs[36] = "Dizona Triceps Bulk"
	morphs[37] = "Dizona Tricep Skinny"
	morphs[38] = "Dizona Ribs In"
	morphs[39] = "Dizona Ribs Out"
	morphs[40] = "Dizona Torso Expand"
	morphs[41] = "Dizona Torso Contract"
	morphs[42] = "Dizona Chest Out"
	morphs[43] = "Dizona Chest Cavity"
	morphs[44] = "Dizona Chest Up"
	morphs[45] = "Dizona Chest Down"
	morphs[46] = "Dizona Chest Together"
	morphs[47] = "Dizona Chest Apart"
	morphs[48] = "Dizona Chest In"
	morphs[49] = "Dizona Chest Lift"
	morphs[50] = "Dizona Chest Sag"
	morphs[51] = "Dizona Chest Pointy"
	morphs[52] = "Dizona Fat Chest"
	morphs[53] = "Dizona Little Chest"
	morphs[54] = "Dizona Nipples Pointy"
	morphs[55] = "Dizona Nipples Big"
	morphs[56] = "Dizona Nipples Little"
	morphs[57] = "Dizona Nipple Slim"
	morphs[58] = "Dizona Nipples Up"
	morphs[59] = "Dizona Nipples Down"
	morphs[60] = "Dizona Nipples Apart"
	morphs[61] = "Dizona Nipples Together"
	morphs[62] = "Dizona Spin"
	morphs[63] = "Dizona Back Up"
	morphs[64] = "Dizona Back Down"
	morphs[65] = "Dizona Lower Back"
	morphs[66] = "Dizona Neck High"
	morphs[67] = "Dizona Neck Low"
	morphs[68] = "Dizona Collar Bone"
	morphs[69] = "Dizona Thick Front Legs"
	morphs[70] = "Dizona Thin Front Legs"
	morphs[71] = "Dizona Thick Legs"
	morphs[72] = "Dizona Thin Legs"
	morphs[73] = "Dizona Big Knees"
	morphs[74] = "Dizona Small Knees"
	morphs[75] = "Dizona Big Calves"
	morphs[76] = "Dizona Small Calves"
	morphs[77] = "Dizona Knee Height"
	morphs[78] = "Dizona Love Handles"
	morphs[79] = "Dizona Skinny Hip Bones"
	morphs[80] = "Dizona Thick Waist"
	morphs[81] = "Dizona Thin Waist"
EndFunction

Event OnCategoryRequest()
	AddCategory(CATEGORY_KEY, "Dizona MORPHS", -945)
	InitMorphNames()
EndEvent

;Add custom sliders here
Event OnSliderRequest(Actor player, ActorBase playerBase, Race actorRace, Bool isFemale)
	If !isFemale && CheckNiOverride()
		AddSliderEx("Reset", CATEGORY_KEY, CALLBACK_PART + "Reset", 0.0, 2.0, 1.0, 0.0)

		Int m
		While m < morphs.Length
			AddSliderEx(morphs[m], CATEGORY_KEY, CALLBACK_PART + morphs[m], -1.0, 1.0, 0.01, getBodyMorph(morphs[m]))
			m += 1
		EndWhile
		
		Version = RM_Dizona_VERSION
	Endif
EndEvent

Event OnSliderChanged(String callback, Float value)
	If CheckNiOverride()
		If callback == (CALLBACK_PART + "Reset")
			If value == 2.0
				clearBodyMorphs()
			EndIf
		Else
			Int m
			While m < morphs.Length
				If callback == (CALLBACK_PART + morphs[m])
					addBodyMorph(morphs[m], value)
				EndIf
				m += 1
			EndWhile
		EndIf
	Endif
EndEvent

Function addBodyMorph(String morphName, Float value)
	NiOverride.SetBodyMorph(_targetActor, morphName, MORPH_KEY, value)
	NiOverride.UpdateModelWeight(_targetActor)
EndFunction

Float Function getBodyMorph(String morphName)
	Return NiOverride.GetBodyMorph(_targetActor, morphName, MORPH_KEY)
EndFunction

Function clearBodyMorphs()
	NiOverride.ClearBodyMorphKeys(_targetActor, MORPH_KEY)
	NiOverride.UpdateModelWeight(_targetActor)

	Int sliderPosFlag = 1 + 2 + 4 + 8
	Int sliderUpdateFlag = 2 + 4 + 8
	String[] sliderNames = Utility.CreateStringArray(morphs.Length + 1)
	Float[] sliderValues = Utility.CreateFloatArray(morphs.Length + 1)
	Int[] sliderFlags = Utility.CreateIntArray(morphs.Length + 1, sliderPosFlag)

	Int m
	While m < morphs.Length
		sliderNames[m] = CALLBACK_PART + morphs[m]
		m += 1
	EndWhile

	sliderNames[sliderNames.Length - 1] = CALLBACK_PART + "Reset"
	sliderFlags[sliderFlags.Length - 1] = sliderUpdateFlag

	SetSliderParametersEx(sliderNames, sliderValues, sliderValues, sliderValues, sliderValues, sliderFlags)
EndFunction
