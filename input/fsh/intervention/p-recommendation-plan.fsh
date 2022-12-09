// Author: Gregor Lichtner @glichtner
Profile: RecommendationPlan
Parent: CPGRecommendationDefinition
Id: recommendation-plan
Title: "Recommendation Plan"
Description: "Definition of an activity that is part of an intervention in the context of a clinical practice guideline recommendation."
* insert metadata(2022-12-08, #draft, 0.3.0)
* insert profile("This profile is used to define the recommended activities for an intervention in the context of a clinical practice guideline recommendation.")
* obeys selection-behavior-unique-or-no-value
* subject[x] 1..1 MS
* subject[x] only canonical
* subjectCanonical only Canonical(RecommendationEligibilityCriteria)
* version 1..1 MS
* name 1..1 MS
* title 1..1
* date 1..1
* description 1..1
* extension[knowledgeCapability] 1..1
  * valueCode 1..1
  * valueCode = $cs-cpg-knowledgeCapability#computable "Computable"
* extension[knowledgeRepresentationLevel] 1..1
  * valueCode 1..1
  * valueCode = $cs-cpg-knowledgeRepresentationLevel#structured "Structured"
* extension[partOf] 1..1
  * valueCanonical 1..1 MS
  * valueCanonical only Canonical(Recommendation)
* action 1..*
* action ^slicing.discriminator.type = #pattern
* action ^slicing.discriminator.path = "code"
* action ^slicing.rules = #open
* action contains
    drugAdministration 0..* and
    ventilatorManagement 0..* and
    bodyPositioning 0..*
  * code 1..1 MS
    * coding 1..*
      * system 1..
      * code 1..
  * goalId
    * obeys goal-must-be-linked
  * definition[x] 0..1 MS
  * definition[x] only canonical
  * definitionCanonical only Canonical(RecommendationAction)
  * selectionBehavior from vs-action-selection-behavior-required (required)
* action[drugAdministration]
  * code = $sct#432102000 "Administration of substance (procedure)"
  * definitionCanonical only Canonical(DrugAdministrationAction)
* action[ventilatorManagement]
  * code = $sct#410210009 "Ventilator care management (procedure)"
  * goalId 1..* MS
* action[bodyPositioning]
  * code = $sct#229824005 "Positioning patient (procedure)"
  * definitionCanonical only Canonical(BodyPositioningAction)
* goal 0..* MS
  * category 1..1 MS
    * coding 1..*
      * system 1..
      * code 1..
  * id 1..1 MS
* goal ^slicing.discriminator.type = #pattern
* goal ^slicing.discriminator.path = "category"
* goal ^slicing.rules = #closed
* goal contains
    ventilatorManagement 0..* and
    laboratoryValue 0..*
* goal[ventilatorManagement]
  * category = $sct#385857005 "Ventilator care and adjustment (regime/therapy)"
  * target 1..*
    * measure 1..1 MS
    * measure from $vs-mii-code-observation-beatmung-loinc (extensible)
    * detail[x] 1..1 MS
* goal[laboratoryValue]
  * category = $sct#410394004 "Lab findings surveillance (regime/therapy)"
  * target 1..*
    * measure 1..1 MS
      * coding
        * ^patternCoding.system = $loinc
        * system 1.. MS
        * code 1.. MS
    * detail[x] 1..1 MS

Invariant: goal-must-be-linked
Description: "The goal linked by goalId is not defined"
Expression: "$this in %resource.goal.id"
Severity: #error

Instance: ExampleRecommendationPlan
InstanceOf: recommendation-plan
Usage: #example
Title: "Example Recommendation plan"
Description: "An active recommendation plan."
* name = "RecommendationPlan"
* title = "Recommendation Plan"
* version = "1.0"
* date = "2022-02-14"
* status = #active
* description = "Example Recommendation Plan"
* insert canonical-url(example/recommendation-plan/example-recommendation-plan)
* experimental = true
* publisher = "CPGonEBMonFHIR"
* subjectCanonical = Canonical(ExampleRecommendationEligibilityCriteria)
* extension[partOf].valueCanonical = Canonical(ExampleRecommendation)
* action[drugAdministration][+]
  * code = $sct#432102000 "Administration of substance (procedure)"
  * definitionCanonical = Canonical(ExampleDrugAdministrationAction)
  * selectionBehavior = #exactly-one
* action[bodyPositioning][+]
  * code = $sct#229824005 "Positioning patient (procedure)"
  * definitionCanonical = Canonical(ExampleBodyPositioningAction)
  * goalId[+] = "ventilator-management-goal"
  * selectionBehavior = #exactly-one
* action[ventilatorManagement][+]
  * code = $sct#410210009 "Ventilator care management (procedure)"
  * goalId[+] = "ventilator-management-goal"
* goal[ventilatorManagement][+]
  * category = $sct#385857005 "Ventilator care and adjustment (regime/therapy)"
  * id = "ventilator-management-goal"
  * description.text = "The ventilator should be set up to provide a breath reate of at least 20 and at most per minute."
  * target
    * measure = $loinc#33438-3 "Breath rate mechanical --on ventilator"
    * detailRange
      * low = 20 '/min'
      * high = 24 '/min'
* goal[laboratoryValue][+]
  * category = $sct#410394004 "Lab findings surveillance (regime/therapy)"
  * id = "lab-ddimer-concentration-goal"
  * description.text = "D-Dimer concentration shall be below 250 ng/mL"
  * target
    * measure = $loinc#48066-5 "Fibrin D-dimer DDU [Mass/volume] in Platelet poor plasma"
    * detailRange
      * high = 250 'ng/mL'
