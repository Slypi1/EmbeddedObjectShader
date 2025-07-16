Shader "Custom/CabinetWithSquareHole"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
         _Color ("Main Color", Color) = (1,1,1,1)
       
        _Hole1Position ("Hole 1 Center", Vector) = (0, 0, 0, 0)
        _Hole1Size ("Hole 1 Size (Width, Height)", Vector) = (1, 1, 0, 0)
        
       
        _Hole2Position ("Hole 2 Center", Vector) = (0, 0, 0, 0)
        _Hole2Size ("Hole 2 Size (Width, Height)", Vector) = (1, 1, 0, 0)
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 worldPos : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
          
            float3 _Hole1Position;
            float2 _Hole1Size;
            float3 _Hole2Position;
            float2 _Hole2Size;
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                float luminance = dot(col.rgb, float3(0.3, 0.59, 0.11));
                fixed3 colored = _Color.rgb * luminance;
                 fixed3 finalColor = lerp(col.rgb, colored, 0.8);
                
           
                float2 offset1 = abs(i.worldPos.xz - _Hole1Position.xz);
                if (offset1.x < _Hole1Size.x * 0.5 && offset1.y < _Hole1Size.y * 0.5)
                    discard;
                
               
                float2 offset2 = abs(i.worldPos.xz - _Hole2Position.xz);
                if (offset2.x < _Hole2Size.x * 0.5 && offset2.y < _Hole2Size.y * 0.5)
                    discard;
                
                return fixed4(finalColor, col.a);
            }
            ENDCG
        }
    }
}

