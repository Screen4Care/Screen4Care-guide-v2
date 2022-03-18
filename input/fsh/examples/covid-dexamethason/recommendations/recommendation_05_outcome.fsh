Instance: DexamethasoneRatingOutcomeMortality
InstanceOf: certainty-of-evidence-rating
Usage: #example
Title: "" // TODO: add
Description: "" // TODO: add
* date = "2020-01-03"
* extension[status].valueCode = #active
* extension[version].valueString = "v4.0"
* artifactReference = Reference(DexamethasoneOutcomeMortality)
* content[certaintyOfEvidence].classifier = $cs-certainty-rating#moderate "Moderate quality"
* content[clinicalImportance].classifier = $cs-clinical-importance#9 "Critical"
* content[riskOfBias].classifier = $cs-certainty-rating#serious-concern "serious concern"
* content[inconsistency].classifier = $cs-certainty-rating#no-concern "no serious concern"
* content[indirectness].classifier = $cs-certainty-rating#no-concern "no serious concern"
* content[imprecision].classifier = $cs-certainty-rating#no-concern "no serious concern"
* content[publicationBias].classifier = $cs-certainty-rating#no-concern "no serious concern"

Instance: DexamethasoneOutcomeMortality
InstanceOf: outcome-evidence
Usage: #example
Title: ""
Description: ""
* name = "ExampleOutcomeEvidence"
* status = #active
* studyType = $cs-study-type#RCT
* synthesisType = $cs-synthesis-type#NotApplicable
* relatedArtifact[studyCitation].resourceReference = Reference(SystemicCorticosteroidsForTheTreatmentOfCOVID19)
* variableDefinition[population].observed = Reference(StudyGroupSystemicCorticosteroidsCOVID19)
* variableDefinition[outcome].observed = Reference(OutcomeAllCauseMortality)
* statistic[relativeEffect]
  * statisticType = $cs-statistic-type#C93152	"Relative Risk"
  * quantity.value = 0.89
  * attributeEstimate[confidenceInterval]
    * range.low.value = 0.80
    * range.high.value = 1.00
  * sampleSize
    * numberOfStudies = 9
    * numberOfParticipants = 7930
* statistic[baselineRisk].quantity = 245 '1/1000'

Instance: StudyGroupSystemicCorticosteroidsCOVID19
InstanceOf: study-group
Usage: #example
Title: "Study group for Systemic corticosteroids plus standard care vs. standard care (plus/minus placebo)"
Description: "Study group for Systemic corticosteroids plus standard care vs. standard care (plus/minus placebo)."
* characteristic
  * valueReference = Reference(StudyEligibilityCriteriaSystemicCorticosteroidsCOVID19)
* characteristic[=].exclude = false // no need to exclude outcomes

Instance: StudyEligibilityCriteriaSystemicCorticosteroidsCOVID19
InstanceOf: study-eligibility-criteria
Usage: #example
Title: "Study eligibility criteria for Systemic corticosteroids plus standard care vs. standard care (plus/minus placebo)"
Description: "Study eligibility criteria for Systemic corticosteroids plus standard care vs. standard care (plus/minus placebo)"
* name = "StudyEligibilityCriteriaSystemicCorticosteroidsCOVID19"
* status = #active
* characteristic[+]
  * typeCodeableConcept.coding[sct] = $sctIntl2021#840539006 "Disease caused by Severe acute respiratory syndrome coronavirus 2 (disorder)"
  * valueBoolean = true
* characteristic[=].exclude = false

Instance: OutcomeAllCauseMortality
InstanceOf: outcome-evidence-variable
Usage: #example
Title: "All-cause mortality"
Description: "All-cause mortality."
* status = #active
* handling = #dichotomous
* name = "AllCauseMortality"
* characteristic
  * definitionCodeableConcept = $sct#409651001 "Mortality rate (observable entity)"
* characteristic[=].exclude = false // no need to exclude outcomes
