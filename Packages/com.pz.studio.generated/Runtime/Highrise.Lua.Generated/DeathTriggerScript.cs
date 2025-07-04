/*

    Copyright (c) 2025 Pocketz World. All rights reserved.

    This is a generated file, do not edit!

    Generated by com.pz.studio
*/

#if UNITY_EDITOR

using System;
using System.Linq;
using UnityEngine;
using Highrise.Client;
using Highrise.Studio;
using Highrise.Lua;
using UnityEditor;

namespace Highrise.Lua.Generated
{
    [AddComponentMenu("Lua/DeathTriggerScript")]
    [LuaRegisterType(0x67fd0ce6653e467c, typeof(LuaBehaviour))]
    public class DeathTriggerScript : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "2a8c78e06d6b59549b49e942a92f7228";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public Highrise.AudioShader m_trapSound = default;
        [SerializeField] public System.Boolean m_Moving = false;
        [SerializeField] public System.Double m_Duration = 2;
        [SerializeField] public UnityEngine.Transform m_pointB = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_trapSound),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_Moving),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_Duration),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_pointB),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/DeathTriggerScript/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
