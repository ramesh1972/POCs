using AutoMapper;
using DestinyLimoServer.DTOs.RequestDTOs;
using DestinyLimoServer.DTOs.ResponseDTOs;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Common.Mapper
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, DTOs.RequestDTOs.UserDTO>()
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.Username, opt => opt.MapFrom(src => src.username))
            .ForMember(dest => dest.Password, opt => opt.MapFrom(src => src.password_hash))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.email))
            .ForMember(dest => dest.IsApproved, opt => opt.MapFrom(src => src.is_approved))
            .ForMember(dest => dest.ApproveRejectReason, opt => opt.MapFrom(src => src.approved_rejected_reason))
            .ForMember(dest => dest.ApprovedByAdminId, opt => opt.MapFrom(src => src.approved_rejected_by))
            .ForMember(dest => dest.ApprovedAt, opt => opt.MapFrom(src => src.approved_rejected_datetime))
            .ForMember(dest => dest.IsLocked, opt => opt.MapFrom(src => src.is_locked))
            .ForMember(dest => dest.IsDeleted, opt => opt.MapFrom(src => src.is_deleted))
            .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(src => src.created_at))
            .ForMember(dest => dest.UpdatedAt, opt => opt.MapFrom(src => src.updated_at))
            .ForMember(dest => dest.UserProfile, opt => opt.MapFrom(src => src.UserProfile))
            .ForMember(dest => dest.Roles, opt => opt.MapFrom(src => src.user_roles)).ReverseMap();

            CreateMap<User, DTOs.ResponseDTOs.UserDTO>()
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.Username, opt => opt.MapFrom(src => src.username))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.email))
            .ForMember(dest => dest.IsApproved, opt => opt.MapFrom(src => src.is_approved))
            .ForMember(dest => dest.ApproveRejectReason, opt => opt.MapFrom(src => src.approved_rejected_reason))
            .ForMember(dest => dest.ApprovedByAdminId, opt => opt.MapFrom(src => src.approved_rejected_by))
            .ForMember(dest => dest.ApprovedAt, opt => opt.MapFrom(src => src.approved_rejected_datetime))
            .ForMember(dest => dest.IsLocked, opt => opt.MapFrom(src => src.is_locked))
            .ForMember(dest => dest.IsDeleted, opt => opt.MapFrom(src => src.is_deleted))
            .ForMember(dest => dest.CreatedAt, opt => opt.MapFrom(src => src.created_at))
            .ForMember(dest => dest.UpdatedAt, opt => opt.MapFrom(src => src.updated_at))
            .ForMember(dest => dest.UserProfile, opt => opt.MapFrom(src => src.UserProfile))
            .ForMember(dest => dest.Roles, opt => opt.MapFrom(src => src.user_roles)).ReverseMap();

            CreateMap<Role, DTOs.RequestDTOs.RoleDTO>()
            .ForMember(dest => dest.RoleId, opt => opt.MapFrom(src => src.role_id))
            .ForMember(dest => dest.RoleName, opt => opt.MapFrom(src => src.role_name)).ReverseMap();
            
            CreateMap<Role, DTOs.ResponseDTOs.RoleDTO>()
            .ForMember(dest => dest.RoleId, opt => opt.MapFrom(src => src.role_id))
            .ForMember(dest => dest.RoleName, opt => opt.MapFrom(src => src.role_name)).ReverseMap();

            CreateMap<UserRole, DTOs.ResponseDTOs.UserRoleDTO>()
            .ForMember(dest => dest.user_role_id, opt => opt.MapFrom(src => src.user_role_id))
            .ForMember(dest => dest.user_id, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.role_id, opt => opt.MapFrom(src => src.role_id))
            .ForMember(dest => dest.role_name, opt => opt.MapFrom(src => src.role_name))
            .ForMember(dest => dest.created_at, opt => opt.MapFrom(src => src.created_at))
            .ForMember(dest => dest.updated_at, opt => opt.MapFrom(src => src.updated_at)).ReverseMap();

            CreateMap<UserProfile, DTOs.RequestDTOs.UserProfileDTO>()
            .ForMember(dest => dest.ProfileId, opt => opt.MapFrom(src => src.profile_id))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.FirstName, opt => opt.MapFrom(src => src.first_name))
            .ForMember(dest => dest.LastName, opt => opt.MapFrom(src => src.last_name))
            .ForMember(dest => dest.Avatar, opt => opt.MapFrom(src => src.avatar))
            .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.address))
            .ForMember(dest => dest.PhoneNumber, opt => opt.MapFrom(src => src.phone_number))
            .ForMember(dest => dest.Dob, opt => opt.MapFrom(src => src.dob))
            .ForMember(dest => dest.LicenseNumber, opt => opt.MapFrom(src => src.license_number))
            .ForMember(dest => dest.LicenseIssueDate, opt => opt.MapFrom(src => src.license_issue_date))
            .ForMember(dest => dest.LicenseExpiryDate, opt => opt.MapFrom(src => src.license_expiry_date)).ReverseMap();

            CreateMap<UserProfile, DTOs.ResponseDTOs.UserProfileDTO>()
            .ForMember(dest => dest.ProfileId, opt => opt.MapFrom(src => src.profile_id))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.FirstName, opt => opt.MapFrom(src => src.first_name))
            .ForMember(dest => dest.LastName, opt => opt.MapFrom(src => src.last_name))
            .ForMember(dest => dest.Avatar, opt => opt.MapFrom(src => src.avatar))
            .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.address))
            .ForMember(dest => dest.PhoneNumber, opt => opt.MapFrom(src => src.phone_number))
            .ForMember(dest => dest.Dob, opt => opt.MapFrom(src => src.dob))
            .ForMember(dest => dest.LicenseNumber, opt => opt.MapFrom(src => src.license_number))
            .ForMember(dest => dest.LicenseIssueDate, opt => opt.MapFrom(src => src.license_issue_date))
            .ForMember(dest => dest.LicenseExpiryDate, opt => opt.MapFrom(src => src.license_expiry_date)).ReverseMap();

            CreateMap<EntityActionDTO, EntityAction>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.IdCol))
            .ForMember(dest => dest.IdColName, opt => opt.MapFrom(src => src.IdColName))
            .ForMember(dest => dest.ParentTableName, opt => opt.MapFrom(src => src.ParentTableName))
            .ForMember(dest => dest.Action, opt => opt.MapFrom(src => src.Action))
            .ForMember(dest => dest.EntityActionRecords, opt => opt.MapFrom(src => src.Records)).ReverseMap();

            CreateMap<EntityActionRecordDTO, EntityActionRecord>().
            ForMember(dest => dest.ColumnValue, opt => opt.MapFrom(src => src.Value))
            .ForMember(dest => dest.ColumnName, opt => opt.MapFrom(src => src.ColName)).ReverseMap();

            CreateMap<MaterialCategory, MaterialCategoryDTO>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.material_category_id))
            .ForMember(dest => dest.category_name, opt => opt.MapFrom(src => src.category_name))
            .ForMember(dest => dest.category_description, opt => opt.MapFrom(src => src.category_description))
            .ForMember(dest => dest.is_active, opt => opt.MapFrom(src => src.is_active))
            .ForMember(dest => dest.is_deleted, opt => opt.MapFrom(src => src.is_deleted)).ReverseMap();
            
            // response
            CreateMap<Material, DestinyLimoServer.DTOs.ResponseDTOs.MaterialDTO>()
            .ForMember(dest => dest.id, opt => opt.MapFrom(src => src.material_id))
            .ForMember(dest => dest.material_id, opt => opt.MapFrom(src => src.material_id))
            .ForMember(dest => dest.material_type_id, opt => opt.MapFrom(src => src.material_type_id))
            .ForMember(dest => dest.material_category_id, opt => opt.MapFrom(src => src.material_category_id))
            .ForMember(dest => dest.title, opt => opt.MapFrom(src => src.title))
            .ForMember(dest => dest.description, opt => opt.MapFrom(src => src.description))
            .ForMember(dest => dest.thumbnail, opt => opt.MapFrom(src => src.thumbnail))
            .ForMember(dest => dest.background_img, opt => opt.MapFrom(src => src.background_img))
            .ForMember(dest => dest.is_public, opt => opt.MapFrom(src => src.is_public))
            .ForMember(dest => dest.is_active, opt => opt.MapFrom(src => src.is_active))
            .ForMember(dest => dest.is_deleted, opt => opt.MapFrom(src => src.is_deleted))
            .ForMember(dest => dest.created_at, opt => opt.MapFrom(src => src.created_at))
            .ForMember(dest => dest.updated_at, opt => opt.MapFrom(src => src.updated_at)).ReverseMap();

            CreateMap<MaterialFile, MaterialFileDTO>()
            .ForMember(dest => dest.file_id, opt => opt.MapFrom(src => src.file_id))
            .ForMember(dest => dest.file_name, opt => opt.MapFrom(src => src.file_name)).ReverseMap();

            CreateMap<MaterialText, DestinyLimoServer.DTOs.ResponseDTOs.MaterialTextDTO>()
            .ForMember(dest => dest.text_id, opt => opt.MapFrom(src => src.text_id))
            .ForMember(dest => dest.text, opt => opt.MapFrom(src => src.text)).ReverseMap();

            CreateMap<MaterialVideo, MaterialVideoDTO>()
            .ForMember(dest => dest.video_id, opt => opt.MapFrom(src => src.video_id))
            .ForMember(dest => dest.url, opt => opt.MapFrom(src => src.url)).ReverseMap();

            CreateMap<MaterialMCQ, DestinyLimoServer.DTOs.ResponseDTOs.MaterialMCQDTO>()
            .ForMember(dest => dest.question_id, opt => opt.MapFrom(src => src.question_id))
            .ForMember(dest => dest.question_text, opt => opt.MapFrom(src => src.question_text))
            .ForMember(dest => dest.answer_1, opt => opt.MapFrom(src => src.answer_1))
            .ForMember(dest => dest.answer_2, opt => opt.MapFrom(src => src.answer_2))
            .ForMember(dest => dest.answer_3, opt => opt.MapFrom(src => src.answer_3))
            .ForMember(dest => dest.answer_4, opt => opt.MapFrom(src => src.answer_4))
            .ForMember(dest => dest.correct_1, opt => opt.MapFrom(src => src.correct_1))
            .ForMember(dest => dest.correct_2, opt => opt.MapFrom(src => src.correct_2))
            .ForMember(dest => dest.correct_3, opt => opt.MapFrom(src => src.correct_3))
            .ForMember(dest => dest.correct_4, opt => opt.MapFrom(src => src.correct_4)).ReverseMap();

            CreateMap<MaterialMCQ, DestinyLimoServer.DTOs.RequestDTOs.MaterialMCQDTO>()
            .ForMember(dest => dest.question_id, opt => opt.MapFrom(src => src.question_id))
            .ForMember(dest => dest.question_text, opt => opt.MapFrom(src => src.question_text))
            .ForMember(dest => dest.answer_1, opt => opt.MapFrom(src => src.answer_1))
            .ForMember(dest => dest.answer_2, opt => opt.MapFrom(src => src.answer_2))
            .ForMember(dest => dest.answer_3, opt => opt.MapFrom(src => src.answer_3))
            .ForMember(dest => dest.answer_4, opt => opt.MapFrom(src => src.answer_4))
            .ForMember(dest => dest.correct_1, opt => opt.MapFrom(src => src.correct_1))
            .ForMember(dest => dest.correct_2, opt => opt.MapFrom(src => src.correct_2))
            .ForMember(dest => dest.correct_3, opt => opt.MapFrom(src => src.correct_3))
            .ForMember(dest => dest.correct_4, opt => opt.MapFrom(src => src.correct_4)).ReverseMap();

            // request
            CreateMap<Material, DestinyLimoServer.DTOs.RequestDTOs.MaterialDTO>()
            .ForMember(dest => dest.id, opt => opt.MapFrom(src => src.material_id))
            .ForMember(dest => dest.material_id, opt => opt.MapFrom(src => src.material_id))
            .ForMember(dest => dest.material_type_id, opt => opt.MapFrom(src => src.material_type_id))
            .ForMember(dest => dest.material_category_id, opt => opt.MapFrom(src => src.material_category_id))
            .ForMember(dest => dest.title, opt => opt.MapFrom(src => src.title))
            .ForMember(dest => dest.description, opt => opt.MapFrom(src => src.description))
            .ForMember(dest => dest.thumbnail, opt => opt.MapFrom(src => src.thumbnail))
            .ForMember(dest => dest.background_img, opt => opt.MapFrom(src => src.background_img))
            .ForMember(dest => dest.is_public, opt => opt.MapFrom(src => src.is_public))
            .ForMember(dest => dest.is_active, opt => opt.MapFrom(src => src.is_active))
            .ForMember(dest => dest.is_deleted, opt => opt.MapFrom(src => src.is_deleted))
            .ForMember(dest => dest.created_at, opt => opt.MapFrom(src => src.created_at))
            .ForMember(dest => dest.updated_at, opt => opt.MapFrom(src => src.updated_at)).ReverseMap();

            CreateMap<MaterialText, DestinyLimoServer.DTOs.RequestDTOs.MaterialTextDTO>()
            .ForMember(dest => dest.text_id, opt => opt.MapFrom(src => src.text_id))
            .ForMember(dest => dest.text, opt => opt.MapFrom(src => src.text)).ReverseMap();

            CreateMap<Content, ContentDTO>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.content_id))
            .ForMember(dest => dest.content_type_id, opt => opt.MapFrom(src => src.content_type_id))
            .ForMember(dest => dest.title, opt => opt.MapFrom(src => src.title))
            .ForMember(dest => dest.description, opt => opt.MapFrom(src => src.description))
            .ForMember(dest => dest.is_public, opt => opt.MapFrom(src => src.is_public))
            .ForMember(dest => dest.is_active, opt => opt.MapFrom(src => src.is_active))
            .ForMember(dest => dest.is_deleted, opt => opt.MapFrom(src => src.is_deleted)).ReverseMap();

            CreateMap<UserExam, UserExamDTO>()
            .ForMember(dest => dest.ExamId, opt => opt.MapFrom(src => src.exam_id))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.DateCreated, opt => opt.MapFrom(src => src.date_created))
            .ForMember(dest => dest.DateStarted, opt => opt.MapFrom(src => src.date_started))
            .ForMember(dest => dest.DateCompleted, opt => opt.MapFrom(src => src.date_completed))
            .ForMember(dest => dest.Score, opt => opt.MapFrom(src => src.score))
            .ForMember(dest => dest.Result, opt => opt.MapFrom(src => src.result))
            .ForMember(dest => dest.CertificateUrl, opt => opt.MapFrom(src => src.certificate_url))
            .ForMember(dest => dest.num_questions, opt => opt.MapFrom(src => src.num_questions))
            .ForMember(dest => dest.num_attempted, opt => opt.MapFrom(src => src.num_attempted))
            .ForMember(dest => dest.num_correct, opt => opt.MapFrom(src => src.num_correct))
            .ForMember(dest => dest.num_wrong, opt => opt.MapFrom(src => src.num_wrong))
            .ForMember(dest => dest.min_correct_answers_for_pass, opt => opt
            .MapFrom(src => src.min_correct_answers_for_pass))
            .ReverseMap();

            CreateMap<UserExamAnswer, UserExamAnswerDTO>()
            .ForMember(dest => dest.exam_id, opt => opt.MapFrom(src => src.exam_id))
            .ForMember(dest => dest.exam_question_id, opt => opt.MapFrom(src => src.exam_question_id))
            .ForMember(dest => dest.mcq_id, opt => opt.MapFrom(src => src.mcq_id))
            .ForMember(dest => dest.choice_1_answer, opt => opt.MapFrom(src => src.choice_1_answer))
            .ForMember(dest => dest.choice_2_answer, opt => opt.MapFrom(src => src.choice_2_answer))
            .ForMember(dest => dest.choice_3_answer, opt => opt.MapFrom(src => src.choice_3_answer))
            .ForMember(dest => dest.choice_4_answer, opt => opt.MapFrom(src => src.choice_4_answer))
            .ForMember(dest => dest.attempted, opt => opt.MapFrom(src => src.attempted))
            .ForMember(dest => dest.is_correct, opt => opt.MapFrom(src => src.is_correct))
            .ReverseMap();
    
            CreateMap<UserAskedQuestion, UserAskedQuestionDTO>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.user_question_id))
            .ForMember(dest => dest.AskedBy, opt => opt.MapFrom(src => src.user_id))
            .ForMember(dest => dest.Question, opt => opt.MapFrom(src => src.asked_question))
            .ForMember(dest => dest.Answer, opt => opt.MapFrom(src => src.admin_answer))
            .ForMember(dest => dest.DateAsked, opt => opt.MapFrom(src => src.date_asked))
            .ForMember(dest => dest.DateAnswered, opt => opt.MapFrom(src => src.date_answered))
            .ForMember(dest => dest.AnsweredBy, opt => opt.MapFrom(src => src.admin_user_id))
            .ForMember(dest => dest.is_public, opt => opt.MapFrom(src => src.is_public))
            .ForMember(dest => dest.is_deleted, opt => opt.MapFrom(src => src.is_deleted))
            .ForMember(dest => dest.is_active, opt => opt.MapFrom(src => src.is_active)).ReverseMap();
        }
    }
}