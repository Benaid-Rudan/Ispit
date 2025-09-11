using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eCommerce.Services.Migrations
{
    /// <inheritdoc />
    public partial class addrewardinactivity2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Activity_RewardRule_RewardRuleId",
                table: "Activity");

            migrationBuilder.DropForeignKey(
                name: "FK_RewardRule_Activity_ActivityId1",
                table: "RewardRule");

            migrationBuilder.DropIndex(
                name: "IX_RewardRule_ActivityId1",
                table: "RewardRule");

            migrationBuilder.DropIndex(
                name: "IX_Activity_RewardRuleId",
                table: "Activity");

            migrationBuilder.DropColumn(
                name: "ActivityId1",
                table: "RewardRule");

            migrationBuilder.DropColumn(
                name: "RewardRuleId",
                table: "Activity");

            migrationBuilder.CreateIndex(
                name: "IX_RewardRule_ActivityId",
                table: "RewardRule",
                column: "ActivityId");

            migrationBuilder.AddForeignKey(
                name: "FK_RewardRule_Activity_ActivityId",
                table: "RewardRule",
                column: "ActivityId",
                principalTable: "Activity",
                principalColumn: "ActivityId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_RewardRule_Activity_ActivityId",
                table: "RewardRule");

            migrationBuilder.DropIndex(
                name: "IX_RewardRule_ActivityId",
                table: "RewardRule");

            migrationBuilder.AddColumn<int>(
                name: "ActivityId1",
                table: "RewardRule",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "RewardRuleId",
                table: "Activity",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_RewardRule_ActivityId1",
                table: "RewardRule",
                column: "ActivityId1");

            migrationBuilder.CreateIndex(
                name: "IX_Activity_RewardRuleId",
                table: "Activity",
                column: "RewardRuleId");

            migrationBuilder.AddForeignKey(
                name: "FK_Activity_RewardRule_RewardRuleId",
                table: "Activity",
                column: "RewardRuleId",
                principalTable: "RewardRule",
                principalColumn: "RewardRuleId",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_RewardRule_Activity_ActivityId1",
                table: "RewardRule",
                column: "ActivityId1",
                principalTable: "Activity",
                principalColumn: "ActivityId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
