Shader "Custom/Inhale" {
	  Properties {
	  
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
 
 		uniform float4 _P;
 		uniform float _R;
 		uniform float _DT;
 
		struct Input {
			float4 color : COLOR;
		};
		
		float easeOutElastic(float x) {
			float t = x; float b = 0; float c = 1; float d = 1;
			float s=1.70158;float p=0;float a=c;
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (p ==0) p=d*.3;
			if (a < abs(c)) { a=c; s=p/4; }
			else s = p/(2*3.14159265359) * asin (c/a);
			return a*pow(2,-10*t) * sin( (t*d-s)*(2*3.14159265359)/p ) + c + b;
		}
		
		void vert (inout appdata_full v){
			float t = saturate(_Time.y - _DT);
			float4 wPos = mul(_Object2World, v.vertex);
			
			float d = distance(wPos.xyz, _P.xyz);
			wPos.xyz += (_P.xyz - wPos.xyz)*pow(saturate((abs(_R) - d)/abs(_R)),2);
			
			float4 pos = mul(_World2Object, wPos);
			
			if(_R < 0)
				v.vertex.xyz = lerp(pos, v.vertex.xyz, easeOutElastic(t));
			else
				v.vertex.xyz = lerp(v.vertex.xyz, pos.xyz, t);
		}
 
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = 1;
			o.Alpha = 1;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}