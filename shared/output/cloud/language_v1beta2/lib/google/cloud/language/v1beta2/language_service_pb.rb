# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/language/v1beta2/language_service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/language/v1beta2/language_service.proto", :syntax => :proto3) do
    add_message "google.cloud.language.v1beta2.Document" do
      optional :type, :enum, 1, "google.cloud.language.v1beta2.Document.Type"
      optional :language, :string, 4
      optional :reference_web_uri, :string, 5
      optional :boilerplate_handling, :enum, 6, "google.cloud.language.v1beta2.Document.BoilerplateHandling"
      oneof :source do
        optional :content, :string, 2
        optional :gcs_content_uri, :string, 3
      end
    end
    add_enum "google.cloud.language.v1beta2.Document.Type" do
      value :TYPE_UNSPECIFIED, 0
      value :PLAIN_TEXT, 1
      value :HTML, 2
    end
    add_enum "google.cloud.language.v1beta2.Document.BoilerplateHandling" do
      value :BOILERPLATE_HANDLING_UNSPECIFIED, 0
      value :SKIP_BOILERPLATE, 1
      value :KEEP_BOILERPLATE, 2
    end
    add_message "google.cloud.language.v1beta2.Sentence" do
      optional :text, :message, 1, "google.cloud.language.v1beta2.TextSpan"
      optional :sentiment, :message, 2, "google.cloud.language.v1beta2.Sentiment"
    end
    add_message "google.cloud.language.v1beta2.Entity" do
      optional :name, :string, 1
      optional :type, :enum, 2, "google.cloud.language.v1beta2.Entity.Type"
      map :metadata, :string, :string, 3
      optional :salience, :float, 4
      repeated :mentions, :message, 5, "google.cloud.language.v1beta2.EntityMention"
      optional :sentiment, :message, 6, "google.cloud.language.v1beta2.Sentiment"
    end
    add_enum "google.cloud.language.v1beta2.Entity.Type" do
      value :UNKNOWN, 0
      value :PERSON, 1
      value :LOCATION, 2
      value :ORGANIZATION, 3
      value :EVENT, 4
      value :WORK_OF_ART, 5
      value :CONSUMER_GOOD, 6
      value :OTHER, 7
      value :PHONE_NUMBER, 9
      value :ADDRESS, 10
      value :DATE, 11
      value :NUMBER, 12
      value :PRICE, 13
    end
    add_message "google.cloud.language.v1beta2.Token" do
      optional :text, :message, 1, "google.cloud.language.v1beta2.TextSpan"
      optional :part_of_speech, :message, 2, "google.cloud.language.v1beta2.PartOfSpeech"
      optional :dependency_edge, :message, 3, "google.cloud.language.v1beta2.DependencyEdge"
      optional :lemma, :string, 4
    end
    add_message "google.cloud.language.v1beta2.Sentiment" do
      optional :magnitude, :float, 2
      optional :score, :float, 3
    end
    add_message "google.cloud.language.v1beta2.PartOfSpeech" do
      optional :tag, :enum, 1, "google.cloud.language.v1beta2.PartOfSpeech.Tag"
      optional :aspect, :enum, 2, "google.cloud.language.v1beta2.PartOfSpeech.Aspect"
      optional :case, :enum, 3, "google.cloud.language.v1beta2.PartOfSpeech.Case"
      optional :form, :enum, 4, "google.cloud.language.v1beta2.PartOfSpeech.Form"
      optional :gender, :enum, 5, "google.cloud.language.v1beta2.PartOfSpeech.Gender"
      optional :mood, :enum, 6, "google.cloud.language.v1beta2.PartOfSpeech.Mood"
      optional :number, :enum, 7, "google.cloud.language.v1beta2.PartOfSpeech.Number"
      optional :person, :enum, 8, "google.cloud.language.v1beta2.PartOfSpeech.Person"
      optional :proper, :enum, 9, "google.cloud.language.v1beta2.PartOfSpeech.Proper"
      optional :reciprocity, :enum, 10, "google.cloud.language.v1beta2.PartOfSpeech.Reciprocity"
      optional :tense, :enum, 11, "google.cloud.language.v1beta2.PartOfSpeech.Tense"
      optional :voice, :enum, 12, "google.cloud.language.v1beta2.PartOfSpeech.Voice"
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Tag" do
      value :UNKNOWN, 0
      value :ADJ, 1
      value :ADP, 2
      value :ADV, 3
      value :CONJ, 4
      value :DET, 5
      value :NOUN, 6
      value :NUM, 7
      value :PRON, 8
      value :PRT, 9
      value :PUNCT, 10
      value :VERB, 11
      value :X, 12
      value :AFFIX, 13
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Aspect" do
      value :ASPECT_UNKNOWN, 0
      value :PERFECTIVE, 1
      value :IMPERFECTIVE, 2
      value :PROGRESSIVE, 3
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Case" do
      value :CASE_UNKNOWN, 0
      value :ACCUSATIVE, 1
      value :ADVERBIAL, 2
      value :COMPLEMENTIVE, 3
      value :DATIVE, 4
      value :GENITIVE, 5
      value :INSTRUMENTAL, 6
      value :LOCATIVE, 7
      value :NOMINATIVE, 8
      value :OBLIQUE, 9
      value :PARTITIVE, 10
      value :PREPOSITIONAL, 11
      value :REFLEXIVE_CASE, 12
      value :RELATIVE_CASE, 13
      value :VOCATIVE, 14
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Form" do
      value :FORM_UNKNOWN, 0
      value :ADNOMIAL, 1
      value :AUXILIARY, 2
      value :COMPLEMENTIZER, 3
      value :FINAL_ENDING, 4
      value :GERUND, 5
      value :REALIS, 6
      value :IRREALIS, 7
      value :SHORT, 8
      value :LONG, 9
      value :ORDER, 10
      value :SPECIFIC, 11
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Gender" do
      value :GENDER_UNKNOWN, 0
      value :FEMININE, 1
      value :MASCULINE, 2
      value :NEUTER, 3
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Mood" do
      value :MOOD_UNKNOWN, 0
      value :CONDITIONAL_MOOD, 1
      value :IMPERATIVE, 2
      value :INDICATIVE, 3
      value :INTERROGATIVE, 4
      value :JUSSIVE, 5
      value :SUBJUNCTIVE, 6
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Number" do
      value :NUMBER_UNKNOWN, 0
      value :SINGULAR, 1
      value :PLURAL, 2
      value :DUAL, 3
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Person" do
      value :PERSON_UNKNOWN, 0
      value :FIRST, 1
      value :SECOND, 2
      value :THIRD, 3
      value :REFLEXIVE_PERSON, 4
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Proper" do
      value :PROPER_UNKNOWN, 0
      value :PROPER, 1
      value :NOT_PROPER, 2
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Reciprocity" do
      value :RECIPROCITY_UNKNOWN, 0
      value :RECIPROCAL, 1
      value :NON_RECIPROCAL, 2
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Tense" do
      value :TENSE_UNKNOWN, 0
      value :CONDITIONAL_TENSE, 1
      value :FUTURE, 2
      value :PAST, 3
      value :PRESENT, 4
      value :IMPERFECT, 5
      value :PLUPERFECT, 6
    end
    add_enum "google.cloud.language.v1beta2.PartOfSpeech.Voice" do
      value :VOICE_UNKNOWN, 0
      value :ACTIVE, 1
      value :CAUSATIVE, 2
      value :PASSIVE, 3
    end
    add_message "google.cloud.language.v1beta2.DependencyEdge" do
      optional :head_token_index, :int32, 1
      optional :label, :enum, 2, "google.cloud.language.v1beta2.DependencyEdge.Label"
    end
    add_enum "google.cloud.language.v1beta2.DependencyEdge.Label" do
      value :UNKNOWN, 0
      value :ABBREV, 1
      value :ACOMP, 2
      value :ADVCL, 3
      value :ADVMOD, 4
      value :AMOD, 5
      value :APPOS, 6
      value :ATTR, 7
      value :AUX, 8
      value :AUXPASS, 9
      value :CC, 10
      value :CCOMP, 11
      value :CONJ, 12
      value :CSUBJ, 13
      value :CSUBJPASS, 14
      value :DEP, 15
      value :DET, 16
      value :DISCOURSE, 17
      value :DOBJ, 18
      value :EXPL, 19
      value :GOESWITH, 20
      value :IOBJ, 21
      value :MARK, 22
      value :MWE, 23
      value :MWV, 24
      value :NEG, 25
      value :NN, 26
      value :NPADVMOD, 27
      value :NSUBJ, 28
      value :NSUBJPASS, 29
      value :NUM, 30
      value :NUMBER, 31
      value :P, 32
      value :PARATAXIS, 33
      value :PARTMOD, 34
      value :PCOMP, 35
      value :POBJ, 36
      value :POSS, 37
      value :POSTNEG, 38
      value :PRECOMP, 39
      value :PRECONJ, 40
      value :PREDET, 41
      value :PREF, 42
      value :PREP, 43
      value :PRONL, 44
      value :PRT, 45
      value :PS, 46
      value :QUANTMOD, 47
      value :RCMOD, 48
      value :RCMODREL, 49
      value :RDROP, 50
      value :REF, 51
      value :REMNANT, 52
      value :REPARANDUM, 53
      value :ROOT, 54
      value :SNUM, 55
      value :SUFF, 56
      value :TMOD, 57
      value :TOPIC, 58
      value :VMOD, 59
      value :VOCATIVE, 60
      value :XCOMP, 61
      value :SUFFIX, 62
      value :TITLE, 63
      value :ADVPHMOD, 64
      value :AUXCAUS, 65
      value :AUXVV, 66
      value :DTMOD, 67
      value :FOREIGN, 68
      value :KW, 69
      value :LIST, 70
      value :NOMC, 71
      value :NOMCSUBJ, 72
      value :NOMCSUBJPASS, 73
      value :NUMC, 74
      value :COP, 75
      value :DISLOCATED, 76
      value :ASP, 77
      value :GMOD, 78
      value :GOBJ, 79
      value :INFMOD, 80
      value :MES, 81
      value :NCOMP, 82
    end
    add_message "google.cloud.language.v1beta2.EntityMention" do
      optional :text, :message, 1, "google.cloud.language.v1beta2.TextSpan"
      optional :type, :enum, 2, "google.cloud.language.v1beta2.EntityMention.Type"
      optional :sentiment, :message, 3, "google.cloud.language.v1beta2.Sentiment"
    end
    add_enum "google.cloud.language.v1beta2.EntityMention.Type" do
      value :TYPE_UNKNOWN, 0
      value :PROPER, 1
      value :COMMON, 2
    end
    add_message "google.cloud.language.v1beta2.TextSpan" do
      optional :content, :string, 1
      optional :begin_offset, :int32, 2
    end
    add_message "google.cloud.language.v1beta2.ClassificationCategory" do
      optional :name, :string, 1
      optional :confidence, :float, 2
    end
    add_message "google.cloud.language.v1beta2.ClassificationModelOptions" do
      oneof :model_type do
        optional :v1_model, :message, 1, "google.cloud.language.v1beta2.ClassificationModelOptions.V1Model"
        optional :v2_model, :message, 2, "google.cloud.language.v1beta2.ClassificationModelOptions.V2Model"
      end
    end
    add_message "google.cloud.language.v1beta2.ClassificationModelOptions.V1Model" do
    end
    add_message "google.cloud.language.v1beta2.ClassificationModelOptions.V2Model" do
      optional :content_categories_version, :enum, 1, "google.cloud.language.v1beta2.ClassificationModelOptions.V2Model.ContentCategoriesVersion"
    end
    add_enum "google.cloud.language.v1beta2.ClassificationModelOptions.V2Model.ContentCategoriesVersion" do
      value :CONTENT_CATEGORIES_VERSION_UNSPECIFIED, 0
      value :V1, 1
      value :V2, 2
    end
    add_message "google.cloud.language.v1beta2.AnalyzeSentimentRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :encoding_type, :enum, 2, "google.cloud.language.v1beta2.EncodingType"
    end
    add_message "google.cloud.language.v1beta2.AnalyzeSentimentResponse" do
      optional :document_sentiment, :message, 1, "google.cloud.language.v1beta2.Sentiment"
      optional :language, :string, 2
      repeated :sentences, :message, 3, "google.cloud.language.v1beta2.Sentence"
    end
    add_message "google.cloud.language.v1beta2.AnalyzeEntitySentimentRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :encoding_type, :enum, 2, "google.cloud.language.v1beta2.EncodingType"
    end
    add_message "google.cloud.language.v1beta2.AnalyzeEntitySentimentResponse" do
      repeated :entities, :message, 1, "google.cloud.language.v1beta2.Entity"
      optional :language, :string, 2
    end
    add_message "google.cloud.language.v1beta2.AnalyzeEntitiesRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :encoding_type, :enum, 2, "google.cloud.language.v1beta2.EncodingType"
    end
    add_message "google.cloud.language.v1beta2.AnalyzeEntitiesResponse" do
      repeated :entities, :message, 1, "google.cloud.language.v1beta2.Entity"
      optional :language, :string, 2
    end
    add_message "google.cloud.language.v1beta2.AnalyzeSyntaxRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :encoding_type, :enum, 2, "google.cloud.language.v1beta2.EncodingType"
    end
    add_message "google.cloud.language.v1beta2.AnalyzeSyntaxResponse" do
      repeated :sentences, :message, 1, "google.cloud.language.v1beta2.Sentence"
      repeated :tokens, :message, 2, "google.cloud.language.v1beta2.Token"
      optional :language, :string, 3
    end
    add_message "google.cloud.language.v1beta2.ClassifyTextRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :classification_model_options, :message, 3, "google.cloud.language.v1beta2.ClassificationModelOptions"
    end
    add_message "google.cloud.language.v1beta2.ClassifyTextResponse" do
      repeated :categories, :message, 1, "google.cloud.language.v1beta2.ClassificationCategory"
    end
    add_message "google.cloud.language.v1beta2.ModerateTextRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
    end
    add_message "google.cloud.language.v1beta2.ModerateTextResponse" do
      repeated :moderation_categories, :message, 1, "google.cloud.language.v1beta2.ClassificationCategory"
    end
    add_message "google.cloud.language.v1beta2.AnnotateTextRequest" do
      optional :document, :message, 1, "google.cloud.language.v1beta2.Document"
      optional :features, :message, 2, "google.cloud.language.v1beta2.AnnotateTextRequest.Features"
      optional :encoding_type, :enum, 3, "google.cloud.language.v1beta2.EncodingType"
    end
    add_message "google.cloud.language.v1beta2.AnnotateTextRequest.Features" do
      optional :extract_syntax, :bool, 1
      optional :extract_entities, :bool, 2
      optional :extract_document_sentiment, :bool, 3
      optional :extract_entity_sentiment, :bool, 4
      optional :classify_text, :bool, 6
      optional :moderate_text, :bool, 11
      optional :classification_model_options, :message, 10, "google.cloud.language.v1beta2.ClassificationModelOptions"
    end
    add_message "google.cloud.language.v1beta2.AnnotateTextResponse" do
      repeated :sentences, :message, 1, "google.cloud.language.v1beta2.Sentence"
      repeated :tokens, :message, 2, "google.cloud.language.v1beta2.Token"
      repeated :entities, :message, 3, "google.cloud.language.v1beta2.Entity"
      optional :document_sentiment, :message, 4, "google.cloud.language.v1beta2.Sentiment"
      optional :language, :string, 5
      repeated :categories, :message, 6, "google.cloud.language.v1beta2.ClassificationCategory"
      repeated :moderation_categories, :message, 8, "google.cloud.language.v1beta2.ClassificationCategory"
    end
    add_enum "google.cloud.language.v1beta2.EncodingType" do
      value :NONE, 0
      value :UTF8, 1
      value :UTF16, 2
      value :UTF32, 3
    end
  end
end

module Google
  module Cloud
    module Language
      module V1beta2
        Document = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Document").msgclass
        Document::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Document.Type").enummodule
        Document::BoilerplateHandling = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Document.BoilerplateHandling").enummodule
        Sentence = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Sentence").msgclass
        Entity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Entity").msgclass
        Entity::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Entity.Type").enummodule
        Token = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Token").msgclass
        Sentiment = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.Sentiment").msgclass
        PartOfSpeech = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech").msgclass
        PartOfSpeech::Tag = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Tag").enummodule
        PartOfSpeech::Aspect = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Aspect").enummodule
        PartOfSpeech::Case = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Case").enummodule
        PartOfSpeech::Form = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Form").enummodule
        PartOfSpeech::Gender = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Gender").enummodule
        PartOfSpeech::Mood = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Mood").enummodule
        PartOfSpeech::Number = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Number").enummodule
        PartOfSpeech::Person = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Person").enummodule
        PartOfSpeech::Proper = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Proper").enummodule
        PartOfSpeech::Reciprocity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Reciprocity").enummodule
        PartOfSpeech::Tense = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Tense").enummodule
        PartOfSpeech::Voice = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.PartOfSpeech.Voice").enummodule
        DependencyEdge = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.DependencyEdge").msgclass
        DependencyEdge::Label = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.DependencyEdge.Label").enummodule
        EntityMention = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.EntityMention").msgclass
        EntityMention::Type = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.EntityMention.Type").enummodule
        TextSpan = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.TextSpan").msgclass
        ClassificationCategory = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassificationCategory").msgclass
        ClassificationModelOptions = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassificationModelOptions").msgclass
        ClassificationModelOptions::V1Model = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassificationModelOptions.V1Model").msgclass
        ClassificationModelOptions::V2Model = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassificationModelOptions.V2Model").msgclass
        ClassificationModelOptions::V2Model::ContentCategoriesVersion = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassificationModelOptions.V2Model.ContentCategoriesVersion").enummodule
        AnalyzeSentimentRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeSentimentRequest").msgclass
        AnalyzeSentimentResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeSentimentResponse").msgclass
        AnalyzeEntitySentimentRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeEntitySentimentRequest").msgclass
        AnalyzeEntitySentimentResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeEntitySentimentResponse").msgclass
        AnalyzeEntitiesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeEntitiesRequest").msgclass
        AnalyzeEntitiesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeEntitiesResponse").msgclass
        AnalyzeSyntaxRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeSyntaxRequest").msgclass
        AnalyzeSyntaxResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnalyzeSyntaxResponse").msgclass
        ClassifyTextRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassifyTextRequest").msgclass
        ClassifyTextResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ClassifyTextResponse").msgclass
        ModerateTextRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ModerateTextRequest").msgclass
        ModerateTextResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.ModerateTextResponse").msgclass
        AnnotateTextRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnnotateTextRequest").msgclass
        AnnotateTextRequest::Features = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnnotateTextRequest.Features").msgclass
        AnnotateTextResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.AnnotateTextResponse").msgclass
        EncodingType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.language.v1beta2.EncodingType").enummodule
      end
    end
  end
end
