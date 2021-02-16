import sys
# # def longestSubstringFinder(string1, string2):
# #     answer = ""
# #     len1, len2 = len(string1), len(string2)
# #     for i in range(len1):
# #         match = ""
# #         for j in range(len2):
# #             if (i + j < len1 and string1[i + j] == string2[j]):
# #                 match += string2[j]
# #             else:
# #                 if (len(match) > len(answer)): answer = match
# #                 match = ""
# #     return answer

# def getSampleIDs(fastaGlob,gff3Glob):
#     sampleGlob = []
#     if len(fastaGlob) != len(gff3Glob:
#         print("ERROR!, there must be one fasta file for every gff3 file")
#         sys.exit()
#     else:
#         for i in range(len(fastaGlob)):
#             current_assembly = fastaGlob[i]
#             current_annotation = gff3Glob[i]
#             sampleGlob.append(longestSubstringFinder(current_assembly,current_annotation))



SAMPLES, = glob_wildcards("{samples}.fa")

rule final:
    input:
        expand("{samples}.cds", samples = SAMPLES)

rule gff3_to_gtf:
    input:
        "{samples}.gff3"
    output:
        "{samples}.gtf"
    shell:
        "agat_convert_sp_gff2gtf.pl --gff {input} -o {output}"

rule gtf_to_cds:
    input:
        gtf = "{samples}.gtf",
        fasta = "{samples}.fa"
    output:
        "{samples}.cds"
    shell:
        "seqkit subseq --gtf {input.gtf} {input.fasta} > {output}"
