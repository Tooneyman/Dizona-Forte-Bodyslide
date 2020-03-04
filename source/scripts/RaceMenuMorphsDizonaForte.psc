ScriptName RaceMenuMorphsDizonaForte Extends RaceMenuBase

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
    morphs[0]  = "Dizona BodyBuilder"
    morphs[1]  = "Dizona to SAMHigh"
	morphs[2]  = "Dizona to SAMUAL"
	morphs[3]  = "Dizona to SAMSON"
	morphs[4]  = "Dizona ForteHigh"
	morphs[5]  = "Dizona Apple Cheeks"
	morphs[6]  = "Dizona Tight Cheeks"
	morphs[7]  = "Dizona Butt Crack"
	morphs[8]  = "Dizona Fat Ass"
	morphs[9] = "Dizona Push Butt"
	morphs[10] = "Dizona Small Butt"
	morphs[11] = "Dizona Round Cheeks"
	morphs[12] = "Dizona Butt Up"
	morphs[13] = "Dizona Butt Down"
	morphs[14] = "Dizona Spread Cheeks"
	morphs[15] = "Dizona Six Pack"
	morphs[16] = "Dizona Stomach Lining"
	morphs[17] = "Dizona Belly Pup"
	morphs[18] = "Dizona Belly Low"
	morphs[19] = "Dizona Big Belly"
	morphs[20] = "Dizona Beer Gut"
	morphs[21] = "Dizona Begger Belly"
	morphs[22] = "Dizona Belly Button Innie"
	morphs[23] = "Dizona Belly Button Out"
	morphs[24] = "Dizona Shoulders High"
	morphs[25] = "Dizona Shoulders Intrude"
	morphs[26] = "Dizona Shoulder Blades"
	morphs[27] = "Dizona Shoulder Blades In"
	morphs[28] = "Dizona Shoulders Up"
	morphs[29] = "Dizona Shoulders Down"
	morphs[30] = "Dizona Forearms Slim"
	morphs[31] = "Dizona Forearms Thick"
	morphs[32] = "Dizona Arms Extend"
	morphs[33] = "Dizona Front Biceps Macho"
	morphs[34] = "Dizona Front Biceps Thin"
	morphs[35] = "Dizona Triceps Bulk"
	morphs[36] = "Dizona Tricep Skinny"
	morphs[37] = "Dizona Ribs In"
	morphs[38] = "Dizona Ribs Out"
	morphs[39] = "Dizona Torso Expand"
	morphs[40] = "Dizona Torso Contract"
	morphs[41] = "Dizona Chest Out"
	morphs[42] = "Dizona Chest Cavity"
	morphs[43] = "Dizona Chest Up"
	morphs[44] = "Dizona Chest Down"
	morphs[45] = "Dizona Chest Together"
	morphs[46] = "Dizona Chest Apart"
	morphs[47] = "Dizona Chest In"
	morphs[48] = "Dizona Chest Lift"
	morphs[49] = "Dizona Chest Sag"
	morphs[50] = "Dizona Chest Pointy"
	morphs[51] = "Dizona Fat Chest"
	morphs[52] = "Dizona Little Chest"
	morphs[53] = "Dizona Nipples Pointy"
	morphs[54] = "Dizona Nipples Big"
	morphs[55] = "Dizona Nipples Little"
	morphs[56] = "Dizona Nipple Slim"
	morphs[57] = "Dizona Nipples Up"
	morphs[58] = "Dizona Nipples Down"
	morphs[59] = "Dizona Nipples Apart"
	morphs[60] = "Dizona Nipples Together"
	morphs[61] = "Dizona Spine"
	morphs[62] = "Dizona Back Up"
	morphs[63] = "Dizona Back Down"
	morphs[64] = "Dizona Lower Back"
	morphs[65] = "Dizona Neck High"
	morphs[66] = "Dizona Neck Low"
	morphs[67] = "Dizona Collar Bone"
	morphs[68] = "Dizona Thick Front Legs"
	morphs[69] = "Dizona Thin Front Legs"
	morphs[70] = "Dizona Thick Legs"
	morphs[71] = "Dizona Thin Legs"
	morphs[72] = "Dizona Big Knees"
	morphs[73] = "Dizona Small Knees"
	morphs[74] = "Dizona Big Calves"
	morphs[75] = "Dizona Small Calves"
	morphs[76] = "Dizona Knee Height"
	morphs[77] = "Dizona Love Handles"
	morphs[78] = "Dizona Skinny Hip Bones"
	morphs[79] = "Dizona Thick Waist"
	morphs[80] = "Dizona Thin Waist"
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
