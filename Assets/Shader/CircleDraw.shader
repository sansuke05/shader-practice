Shader "Custom/CircleDraw" {
    Properties {
        _Color("Base Color", Color) = (0, 0, 0, 1)
    }
    SubShader {
        Tags {
            "RenderType" = "Opaque"
        }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard
        #pragma target 3.0

        struct Input {
            float3 worldPos;
        };

        fixed4 _Color;

        void surf(Input IN, inout SurfaceOutputStandard o) {
            fixed4 w = fixed4(1, 1, 1, 1);
            float dist = distance( fixed3(0,0,0), IN.worldPos);
            float val = abs(sin(dist*3.0-_Time*100));
            o.Albedo = val > 0.98 ? w : _Color ;
        }

        ENDCG
    }
    Fallback "Diffuse"
}