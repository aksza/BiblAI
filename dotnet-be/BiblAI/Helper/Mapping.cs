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
            CreateMap<User, UserDto>();
            CreateMap<UserCreateDto, User>();
            CreateMap<Post, PostDto>();
            CreateMap<PostCreateDto, Post>();
            CreateMap<Comment, CommentDto>();
            CreateMap<CommentCreateDto, Comment>();
            CreateMap<LikeCreateDto, Like>();
        }
    }
}
