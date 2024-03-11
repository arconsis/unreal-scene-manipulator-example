// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "SpawnableActor.generated.h"

UCLASS()
class SCENEMANIPULATOR_API ASpawnableActor : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	ASpawnableActor();

	// Called every frame
	virtual void Tick(float DeltaTime) override;

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;


public:
	void SetCustomName(FString newName);
	FString GetCustomName();

	UPROPERTY(VisibleAnywhere, meta = (AllowPrivateAccess = "true")) FString CustomName;
};
