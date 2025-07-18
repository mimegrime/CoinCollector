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
    [AddComponentMenu("Lua/PlayerTracker")]
    [LuaRegisterType(0xda26101afdd629bc, typeof(LuaBehaviour))]
    public class PlayerTracker : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "ceec1f725587a584591266998d05e6e6";
        public override string ScriptGUID => s_scriptGUID;

        [Header("CheckPoints")]
        [SerializeField] public Highrise.AudioShader m_checkpointSound = default;
        [SerializeField] public UnityEngine.Transform m_CheckPoint1 = default;
        [SerializeField] public UnityEngine.Transform m_CheckPoint2 = default;
        [SerializeField] public UnityEngine.Transform m_CheckPoint3 = default;
        [SerializeField] public UnityEngine.Transform m_CheckPoint4 = default;
        [Header("Winning Variables")]
        [SerializeField] public System.Double m_winScore = 2;
        [SerializeField] public Highrise.AudioShader m_winSound = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_checkpointSound),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_CheckPoint1),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_CheckPoint2),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_CheckPoint3),
                CreateSerializedProperty(_script.GetPropertyAt(4), m_CheckPoint4),
                CreateSerializedProperty(_script.GetPropertyAt(5), m_winScore),
                CreateSerializedProperty(_script.GetPropertyAt(6), m_winSound),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/PlayerTracker/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
