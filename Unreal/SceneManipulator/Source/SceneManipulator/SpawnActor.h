// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "SpawnableActor.h"
#include "SceneManipulatorGameInstance.h"
#include "SpawnActor.generated.h"

UCLASS()
class SCENEMANIPULATOR_API ASpawnActor : public AActor
{
	GENERATED_BODY()
	
public:	
	ASpawnActor();

protected:
	virtual void BeginPlay() override;

	virtual void ReceiveMessage();
	virtual void DeserializeEntry(const TSharedPtr<FJsonObject>& OutArray);
	virtual void CheckNames();
	virtual void DeserializeMessage(const FString& Message);

	FString LastMessage;
	TArray<FString> ReceivedNames;
	TArray<ASpawnableActor*> SpawnedActors;
	UMaterialInstanceDynamic* Material;

public:	
	virtual void Tick(float DeltaTime) override;
	
	UPROPERTY(EditAnywhere, meta = (AllowPrivateAccess = "true")) UMaterial* StoneMaterial;
	UPROPERTY(EditAnywhere, meta = (AllowPrivateAccess = "true")) UMaterial* WoodMaterial;
	UPROPERTY(EditAnywhere, meta = (AllowPrivateAccess = "true")) TSubclassOf<AActor> Spawnable;
};