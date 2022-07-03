// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/ShaderTest"
{
    Properties
    {
        _Color("Color", Color) = (0.5, 0.5, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityLightingCommon.cginc"


            float4 _Color;
            // Input Struct
            struct appdata
            {
                float4 vertex : POSITION; // Need the vertex pos
                float3 normals : NORMAL;
            };

            // Output Struct
            struct v2f
            {
                float4 pos : POSITION;
                float3 normals : NORMAL;
            };

            // Pixel Shader
            v2f vert (appdata vertex)
            {
                v2f output;
                output.pos = UnityObjectToClipPos(vertex.vertex); // Transform from object space to clip space
                output.normals = vertex.normals; // Normals for light calculations
                return output;
            }

            // FragShader
            fixed4 frag (v2f input) : SV_Target
            {
                // We want the worldSpaceLight to follow us in the direction thats why we multiply by the normales.
                // Then we want to clamp between a value because we dont want darker tones.
                float normalsToLight =  max(0.42, dot(_WorldSpaceLightPos0, input.normals));
                // After all we want the color of the ambient light to be more realistic
                float4 col = float4(normalsToLight.xxx * _LightColor0,0);
                return col;
            }
            ENDCG
        }
    }
}
