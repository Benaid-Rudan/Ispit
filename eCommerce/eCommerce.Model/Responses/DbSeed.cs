//using System;
//using System.Collections.Generic;
//using System.Data;
//using System.Linq;
//using System.Security.Cryptography;
//using System.Text;
//using System.Threading.Tasks;

//namespace eCommerce.Services.Database
//{
//    public static class DbSeed
//    {
//        public static void Seed(eCommerceDbContext context)
//        {
//            if (!context.Roles.Any())
//            {
//                var roles = new List<Role>
//                    {
//                        new Role { Name = "Administrator", Description = "System administrator", CreatedAt = DateTime.UtcNow, IsActive = true },
//                        new Role { Name = "Korisnik", Description = "Regular user", CreatedAt = DateTime.UtcNow, IsActive = true }
//                    };
//                context.Roles.AddRange(roles);
//                context.SaveChanges();
//            }
//            var adminSalt = GenerateSalt();
//            var korisnikSalt = GenerateSalt();
//            // Seed Users
//            if (!context.Users.Any())
//            {
//                var (adminHashValue, adminSaltValue) = HashPassword("admin123");
//                var (korisnikHashValue, korisnikSaltValue) = HashPassword("korisnik123");
//                var users = new List<User>
//                    {
//                        new User
//                        {
//                            FirstName = "Admin",
//                            LastName = "Adminic",
//                            Email = "admin@demo.com",
//                            Username = "admin",
//                            PasswordHash = adminHashValue,
//                            PasswordSalt = adminSaltValue,
//                            IsActive = true,
//                            CreatedAt = DateTime.UtcNow,
//                            PhoneNumber = "061111111",
//                            UserRoles = new List<UserRole>
//                            {
//                                new UserRole
//                                {
//                                    RoleId = context.Roles.First(r => r.Name == "Administrator").Id,
//                                    DateAssigned = DateTime.UtcNow
//                                }
//                            }
//                        },
//                        new User
//                        {
//                            FirstName = "Korisnik",
//                            LastName = "Korisnic",
//                            Email = "korisnik@demo.com",
//                            Username = "korisnik",
//                            PasswordHash = korisnikHashValue,
//                            PasswordSalt = korisnikSaltValue,
//                            IsActive = true,
//                            CreatedAt = DateTime.UtcNow,
//                            PhoneNumber = "062222222",
//                            UserRoles = new List<UserRole>
//                            {
//                                new UserRole
//                                {
//                                    RoleId = context.Roles.First(r => r.Name == "Korisnik").Id,
//                                    DateAssigned = DateTime.UtcNow
//                                }
//                            }
//                        }
//                    };
//                context.Users.AddRange(users);
//                context.SaveChanges();
//            }
//        }

//        private static string GenerateSalt()
//        {
//            var provider = new RNGCryptoServiceProvider();
//            var byteArray = new byte[16];
//            provider.GetBytes(byteArray);

//            return Convert.ToBase64String(byteArray);
//        }

//        private static (string hash, string salt) HashPassword(string password)
//        {
//            var salt = new byte[16];
//            RandomNumberGenerator.Fill(salt);
//            using var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000, HashAlgorithmName.SHA256);
//            var hash = pbkdf2.GetBytes(32);
//            return (Convert.ToBase64String(hash), Convert.ToBase64String(salt));
//        }

//    }
//}