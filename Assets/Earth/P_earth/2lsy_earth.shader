// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/2lsy_earth" {
		Properties {
		    _Color ("Main Color", Color) = (1,1,1,0.5)
		    _MainTex ("Texture", 2D) = "white" { }
		    _Cloud ("_Cloud", 2D) = "white" { }
		//    _Fuck("Fuck",Range(0,1))= 0.4
		}
		SubShader {
		Tags{"Queue" = "Transparent" "RenderType"="Transparent"}
		    Pass {
		
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		#include "UnityCG.cginc"
		
		float4 _Color;
		sampler2D _MainTex;
		sampler2D	_Cloud;
		
		struct v2f {
		    float4  pos : SV_POSITION;
		    float2  uv : TEXCOORD0;
		};
		
		float4 _MainTex_ST;
		
		v2f vert (appdata_base v)
		{
		    v2f o;
		    o.pos = UnityObjectToClipPos (v.vertex);
		    o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
		    return o;
		}
		
		half4 frag (v2f i) : COLOR
		{
			float u = i.uv.x + -0.1*_Time;
			float2 x=float2( u , i.uv.y);
		    half4 texcol = tex2D (_MainTex, x);
		    texcol = texcol;
		     
		    u = i.uv.x + -0.2*_Time;
			x=float2( u , i.uv.y);
			
			half4 texcol3 = tex2D (_Cloud, x);
			half4 texcol0 = float4(1,1,1,0) * (texcol3.x);
		  //  return texcol0+ texcol;
		    return lerp(texcol,texcol0,0.5f);
		}
		ENDCG
		
		 }
		}
//		Properties {
//			_Color ("Main Color", Color) = (1,1,1,1)
//			_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
//		}
//		
//		SubShader {
//			Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
//			LOD 200
//		
//		CGPROGRAM
//		#pragma surface surf Lambert alpha
//		
//		sampler2D _MainTex;
//		fixed4 _Color;
//		
//		struct Input {
//			float2 uv_MainTex;
//		};
//		
//		void surf (Input IN, inout SurfaceOutput o) {
//		    float x = IN.uv_MainTex.x - 0.5 * _Time;
//		    float y = IN.uv_MainTex.y;
//		    float2 myUV = float2(x,y);
//			fixed4 c = tex2D(_MainTex, myUV) * _Color;
//			o.Albedo = c.rgb;
//			o.Alpha = c.a;
//		}
//		ENDCG
//		}
}
