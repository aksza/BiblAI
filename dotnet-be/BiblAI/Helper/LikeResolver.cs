using AutoMapper;
using BiblAI.Dto;
using BiblAI.Interfaces;
using BiblAI.Models;

namespace BiblAI.Helper
{
    public class NumCommentDislikesResolver : IValueResolver<Comment, CommentDto, int>
    {
        private readonly ILikeRepository _likeRepository;

        public NumCommentDislikesResolver(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public int Resolve(Comment source, CommentDto destination, int destMember, ResolutionContext context)
        {
            return _likeRepository.GetCommentDislikes(source.Id);
        }
    }

    public class NumCommentLikesResolver : IValueResolver<Comment, CommentDto, int>
    {
        private readonly ILikeRepository _likeRepository;

        public NumCommentLikesResolver(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public int Resolve(Comment source, CommentDto destination, int destMember, ResolutionContext context)
        {
            return _likeRepository.GetCommentLikes(source.Id);
        }
    }

    public class NumPostDislikesResolver : IValueResolver<Post, PostDto, int>
    {
        private readonly ILikeRepository _likeRepository;

        public NumPostDislikesResolver(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public int Resolve(Post source, PostDto destination, int destMember, ResolutionContext context)
        {
            // Use your like repository to get the number of likes for the post
            return _likeRepository.GetPostDislikes(source.Id);
        }
    }

    public class NumPostLikesResolver : IValueResolver<Post, PostDto, int>
    {
        private readonly ILikeRepository _likeRepository;

        public NumPostLikesResolver(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public int Resolve(Post source, PostDto destination, int destMember, ResolutionContext context)
        {
            // Use your like repository to get the number of likes for the post
            return _likeRepository.GetPostLikes(source.Id);
        }
    }

    public class UserNameResolver : IValueResolver<Post, PostDto, string>
    {
        private readonly IUserRepository _userRepository;

        public UserNameResolver(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public string Resolve(Post source, PostDto destination, string destMember, ResolutionContext context)
        {
            return _userRepository.GetUserById(source.UserId).UserName;
        }
    }

    public class UserNameResolver2 : IValueResolver<Comment, CommentDto, string>
    {
        private readonly IUserRepository _userRepository;

        public UserNameResolver2(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public string Resolve(Comment source, CommentDto destination, string destMember, ResolutionContext context)
        {
            return _userRepository.GetUserById(source.UserId).UserName;
        }
    }

    public class UserPictureResolver : IValueResolver<Post, PostDto, string>
    {
        private readonly IUserRepository _userRepository;

        public UserPictureResolver(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public string Resolve(Post source, PostDto destination, string destMember, ResolutionContext context)
        {
            return _userRepository.GetUserById(source.UserId).ProfilePictureUrl;
        }
    }

    public class UserPictureResolver2 : IValueResolver<Comment, CommentDto, string>
    {
        private readonly IUserRepository _userRepository;

        public UserPictureResolver2(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public string Resolve(Comment source, CommentDto destination, string destMember, ResolutionContext context)
        {
            return _userRepository.GetUserById(source.UserId).ProfilePictureUrl;
        }
    }
}
