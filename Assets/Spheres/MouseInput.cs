using UnityEngine;
using System.Collections;

public class MouseInput : MonoBehaviour {
	float radius = 0;
	float dt = 0;
	
	void Start(){
		Shader.SetGlobalFloat("_R", 0);
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetMouseButtonDown(0)){
			dt = Time.timeSinceLevelLoad;
			Shader.SetGlobalFloat("_DT", dt);
			radius = 0;
		}
		if(Input.GetMouseButton(0)){
			radius = Mathf.Pow(10f*(Time.timeSinceLevelLoad - dt),2f);
			Shader.SetGlobalFloat("_R", radius);
			
			Vector3 pos = Input.mousePosition;
			pos.z = 5f;
			pos = camera.ScreenToWorldPoint(pos);
			Shader.SetGlobalVector("_P", pos);
		}
		if(Input.GetMouseButtonUp(0)){
			Shader.SetGlobalFloat("_DT", Time.timeSinceLevelLoad);
			Shader.SetGlobalFloat("_R", -radius);
		}
	}
}
