Shader "Custom/hamon" {
    Properties {
        _MainTex("Main Texture", 2D) = "white" {}
        //_Color("Base Color", Color) = (0, 0, 0, 1)
    }
    SubShader {
        Tags {
            "RenderType" = "Transparent"
        }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };

        //fixed4 _Color;
        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutputStandard o) {
            float dist = distance( float2(0.5, 0.5), IN.uv_MainTex);
            float val = abs(sin(dist*10-_Time*50));
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
            o.Alpha = val*0.5;
            o.Emission = (1 - val);
        }

        ENDCG
    }
    Fallback "Diffuse"
}