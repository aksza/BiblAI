using AutoMapper;
using BiblAI.Dto;
using BiblAI.Interfaces;
using BiblAI.Models;
using BiblAI.Repository;

namespace BiblAI.Helper
{
    public class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<User, UserDto>()
                .ForMember(dest => dest.Posts, opt => opt.MapFrom(src => src.Posts));
            CreateMap<UserCreateDto, User>();
            CreateMap<Post, PostDto>()
                .ForMember(dest => dest.UserName, opt => opt.MapFrom<UserNameResolver>())
                .ForMember(dest => dest.ProfilePictureUrl, opt => opt.MapFrom<UserPictureResolver>())
                .ForMember(dest => dest.Comments, opt => opt.MapFrom(src => src.Comments))
                .ForMember(dest => dest.NumLikes, opt => opt.MapFrom<NumPostLikesResolver>())
                .ForMember(dest => dest.NumDislikes, opt => opt.MapFrom<NumPostDislikesResolver>());
            CreateMap<PostCreateDto, Post>();
            CreateMap<Comment, CommentDto>()
                .ForMember(dest => dest.UserName, opt => opt.MapFrom<UserNameResolver2>())
                .ForMember(dest => dest.ProfilePictureUrl, opt => opt.MapFrom<UserPictureResolver2>())
                .ForMember(dest => dest.NumLikes, opt => opt.MapFrom<NumCommentLikesResolver>())
                .ForMember(dest => dest.NumDislikes, opt => opt.MapFrom<NumCommentDislikesResolver>());
            CreateMap<CommentCreateDto, Comment>();
            CreateMap<LikeCreateDto, Like>()
                .ForMember(dest => dest.CommentId, opt => opt.Ignore());
        }
    }
}
