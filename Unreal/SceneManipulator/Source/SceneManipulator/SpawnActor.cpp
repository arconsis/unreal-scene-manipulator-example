// Fill out your copyright notice in the Description page of Project Settings.


#include "SpawnActor.h"
#include "SceneManipulatorGameInstance.h"
#include "String.h"
#include "Json.h"
#include "SpawnableActor.h"
#include <Kismet/GameplayStatics.h>

// Sets default values
ASpawnActor::ASpawnActor() {

 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	LastMessage = "";

	/**
	static ConstructorHelpers::FObjectFinder<UMaterial> FoundMaterial(TEXT("/Game/Materials/Wood"));
	if (FoundMaterial.Succeeded()) {
		WoodMaterial = FoundMaterial.Object;
	}

	static ConstructorHelpers::FObjectFinder<UMaterial> FoundMaterial2(TEXT("/Game/Materials/Stone"));
	if (FoundMaterial2.Succeeded()) {
		StoneMaterial = FoundMaterial2.Object;
	}
	*/
}

// Called when the game starts or when spawned
void ASpawnActor::BeginPlay() {
	Super::BeginPlay();
}

// Called every frame
void ASpawnActor::Tick(float DeltaTime) {
	Super::Tick(DeltaTime);

	ReceiveMessage();
}

void ASpawnActor::ReceiveMessage() {
	USceneManipulatorGameInstance* gameInstance = Cast<USceneManipulatorGameInstance>(GetGameInstance());

	if (gameInstance) {

		if (gameInstance->WebSocket->IsConnected()) {
			gameInstance->WebSocket->OnMessage().AddLambda([&](const FString& MessageString) {
				if (LastMessage == MessageString) {
					return;
				} else {
					UE_LOG(LogTemp, Error, TEXT("This is the data: %s"), *MessageString);
					LastMessage = MessageString;

					DeserializeMessage(MessageString);
				}
			});
		}
	}
}

void ASpawnActor::DeserializeMessage(const FString& Message) {
	TSharedPtr<FJsonValue> Out;
	TArray<TSharedPtr<FJsonValue>> OutArray;
	TSharedRef<TJsonReader<>> JsonReader = TJsonReaderFactory<>::Create(Message);

	if (FJsonSerializer::Deserialize(JsonReader, Out)) {
		OutArray = Out->AsObject()->GetArrayField("objects");

		for (int i = 0; i < OutArray.Num(); ++i) {
			DeserializeEntry(OutArray[i]->AsObject());
		}
	} else {
		UE_LOG(LogTemp, Error, TEXT("Failed to deserialize message"));
	}

	CheckNames();
}

void ASpawnActor::DeserializeEntry(const TSharedPtr<FJsonObject>& OutArray) {
	USceneManipulatorGameInstance* gameInstance = Cast<USceneManipulatorGameInstance>(GetGameInstance());

	//SpawnedActors = gameInstance->SpawnedActors;
	ASpawnableActor* actor = nullptr;

	const FString JsonName = OutArray->GetStringField("name");
	ReceivedNames.Add(JsonName);

	for (int i = 0; i < SpawnedActors.Num(); ++i) {
		FString name = SpawnedActors[i]->GetCustomName();

		if (JsonName == name) {
			actor = (ASpawnableActor*)SpawnedActors[i];
			break;
		}
	}

	if (actor == nullptr) {
		const FVector loc = FVector(1, 1, 1);
		const FRotator rot = FRotator(1, 1, 1);
		FActorSpawnParameters SpawnInfo;
		SpawnInfo.SpawnCollisionHandlingOverride = ESpawnActorCollisionHandlingMethod::AlwaysSpawn;
		actor = (ASpawnableActor*)GetWorld()->SpawnActor<ASpawnableActor>(Spawnable, loc, rot, SpawnInfo);

		if (actor != nullptr) {
			actor->SetCustomName(JsonName);
			SpawnedActors.Add(actor);
			//gameInstance->SpawnedActors.Add(actor);
		}
		else {
			GEngine->AddOnScreenDebugMessage(-1, 15.0f, FColor::Red, "Error");
			return;
		}
	}

	const TSharedPtr<FJsonValue> JsonLocationPtr = OutArray->GetField<EJson::Object>("location");
	const TSharedPtr<FJsonValue> JsonScalePtr = OutArray->GetField<EJson::Object>("scale");
	const TSharedPtr<FJsonValue> JsonMatPtr = OutArray->GetField<EJson::Object>("material");

	const TSharedPtr<FJsonObject> JsonLocation = JsonLocationPtr->AsObject();
	const TSharedPtr<FJsonObject> JsonScale = JsonScalePtr->AsObject();
	const TSharedPtr<FJsonObject> JsonMat = JsonMatPtr->AsObject();

	//Get Location
	double locationX = 0.;
	double locationY = 0.;
	double locationZ = 0.;
	JsonLocation->TryGetNumberField(TEXT("xCoordinate"), locationX);
	JsonLocation->TryGetNumberField(TEXT("yCoordinate"), locationY);
	JsonLocation->TryGetNumberField(TEXT("zCoordinate"), locationZ);
	FVector location = FVector(locationX, locationY, locationZ);

	//Get Scale
	double scaleX = 0.;
	double scaleY = 0.;
	double scaleZ = 0.;
	JsonScale->TryGetNumberField(TEXT("xCoordinate"), scaleX);
	JsonScale->TryGetNumberField(TEXT("yCoordinate"), scaleY);
	JsonScale->TryGetNumberField(TEXT("zCoordinate"), scaleZ);
	FVector scale = FVector(scaleX, scaleY, scaleZ);

	//Get Material
	FString materialName = "";
	double tintIntensity = 1.0;
	double redTint = 0;
	double greenTint = 0;
	double blueTint = 0;
	JsonMat->TryGetStringField(TEXT("materialName"), materialName);
	JsonMat->TryGetNumberField(TEXT("tintIntensity"), tintIntensity);
	JsonMat->TryGetNumberField(TEXT("redTint"), redTint);
	JsonMat->TryGetNumberField(TEXT("greenTint"), greenTint);
	JsonMat->TryGetNumberField(TEXT("blueTint"), blueTint);
	FVector tintColor = FVector(redTint, greenTint, blueTint);

	if (materialName == "Wood") {
		Material = UMaterialInstanceDynamic::Create(WoodMaterial, GetOuter());
	} else if (materialName == "Stone") {
		Material = UMaterialInstanceDynamic::Create(StoneMaterial, GetOuter());
	}

	if (Material != nullptr) {
		Material->SetVectorParameterValue(FName("TintColor"), tintColor);
		Material->SetScalarParameterValue(FName("TintIntensity"), tintIntensity);
	}

	TArray<UStaticMeshComponent*> Components;
	actor->GetComponents<UStaticMeshComponent>(Components, true);
	for (int32 i = 0; i < Components.Num(); i++) {
		UStaticMeshComponent* StaticMeshComponent = Components[i];

		StaticMeshComponent->SetMaterial(0, Material);
		StaticMeshComponent->SetWorldScale3D(scale);
		StaticMeshComponent->SetWorldLocation(location);

	}
}

void ASpawnActor::CheckNames() {
	USceneManipulatorGameInstance* gameInstance = Cast<USceneManipulatorGameInstance>(GetGameInstance());
	TArray<int> uncommonActorsIndex;

	for (int i = 0; i < SpawnedActors.Num(); i++) {
		FString name = SpawnedActors[i]->GetCustomName();

		for (int j = 0; j < ReceivedNames.Num(); j++) {
			if (name == ReceivedNames[j]) {
				break;
			}

			if (j == ReceivedNames.Num() - 1) {
				uncommonActorsIndex.Add(i);
			}
		}
	}

	for (int k = 0; k < uncommonActorsIndex.Num(); k++) {
		int index = uncommonActorsIndex[k];

		SpawnedActors[index]->Destroy();
		//gameInstance->SpawnedActors.RemoveAt(index);
		SpawnedActors.RemoveAt(index);
	}

	ReceivedNames.Empty();
}