using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CameraPostProcessing : MonoBehaviour
{
	Material material;
	public float offset;
	
	void Awake()
	{
		material = new Material(Shader.Find("Hidden/NewImageEffectShader"));

	}

	void OnRenderImage(RenderTexture _src, RenderTexture _dst)
	{
		Graphics.Blit(_src, _dst, material);
	}

	void OnValidate()
	{
		material.SetFloat("_Offset", offset);
	}
}
