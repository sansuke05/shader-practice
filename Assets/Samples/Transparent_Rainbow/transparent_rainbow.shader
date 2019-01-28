// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/transparent_rainbow"
{
	Properties
	{
		_Speed("Speed", Range( 0 , 3)) = 1
		_Value("Value", Range( 0 , 1)) = 0.5
		_Saturation("Saturation", Range( 0 , 1)) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D _GrabTexture;
		uniform float _Speed;
		uniform float _Saturation;
		uniform float _Value;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 screenColor40 = tex2D( _GrabTexture, ase_screenPosNorm.xy );
			o.Albedo = screenColor40.rgb;
			float mulTime37 = _Time.y * _Speed;
			float3 hsvTorgb7 = HSVToRGB( float3(mulTime37,_Saturation,_Value) );
			o.Emission = hsvTorgb7;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16000
1058;112;728;1346;784.3073;538.0684;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;38;-597.2993,-62.40002;Float;False;Property;_Speed;Speed;0;0;Create;True;0;0;False;0;1;0.95;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-329.3532,4.226261;Float;False;Property;_Saturation;Saturation;2;0;Create;True;0;0;False;0;0.5;0.187;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-313.3934,94.91284;Float;False;Property;_Value;Value;1;0;Create;True;0;0;False;0;0.5;0.265;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;43;-293.8376,-326.3203;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;37;-313.298,-57.80011;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;7;-58.27109,-8.742372;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScreenColorNode;40;33.191,-262.7003;Float;False;Global;_GrabScreen1;Grab Screen 1;2;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;244.3383,-73.8923;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Custom/transparent_rainbow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;True;0;False;Opaque;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;38;0
WireConnection;7;0;37;0
WireConnection;7;1;46;0
WireConnection;7;2;47;0
WireConnection;40;0;43;0
WireConnection;0;0;40;0
WireConnection;0;2;7;0
ASEEND*/
//CHKSM=18192CD33ACE84B3730F0231E4D7126B497F9D7D